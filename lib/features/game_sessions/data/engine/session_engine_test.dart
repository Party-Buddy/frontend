import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:party_games_app/config/consts.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/utils/sync_counter.dart';
import 'package:party_games_app/features/game_sessions/data/models/current_task_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_player_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_results_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_session_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/poll_info_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/task_results_model.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_results.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/poll_info.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_answer.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_results.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_uid.dart';
import 'package:synchronized/synchronized.dart';

class SessionEngineTestImpl implements SessionEngine {
  late final Future<String> uidGetter;
  String? uid;
  final Lock _stateLock = Lock();
  GameState state = GameState.closed;

  Function(GameSession)? _onGameStatus;
  Function(int?)? _onGameStart;
  Function(String)? _onGameInterrupted;
  Function(String)? _onOpError;
  Function(CurrentTask)? _onTaskStart;
  Function(TaskResults)? _onTaskEnd;
  Function(PollInfo)? _onPollStart;
  Function(GameResults)? _onGameEnd;
  GameSessionModel gameSession = GameSessionModel();
  SyncCounter messageIdGenerator = SyncCounter();
  String nickname = 'Your nickname';
  int maxPlayers = maxPossiblePlayersCount;
  var logger = Logger();
  Completer<DataState<String>>? joinCompleter;

  SessionEngineTestImpl() {
    uidGetter = GetIt.instance<GetUIDUseCase>().call();
  }

  void _sendGameStatus() {
    _onGameStatus?.call(gameSession.toEntity());
  }

  void _onJoinedMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.start) {
        return;
      }
      joinCompleter?.complete(DataSuccess(data['session-id'] ?? ''));
      gameSession = GameSessionModel.fromJson(data);
      _sendGameStatus();
      state = GameState.lobby;
    });
  }

  void _onWaitingMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.lobby) {
        return;
      }
      if (gameSession.players != null) {
        var players = gameSession.players!
            .map((player) =>
                ((data['ready'] as List?)?.contains(player.id) ?? false)
                    ? player.copyWith(ready: true)
                    : player.copyWith(ready: false))
            .toList();
        gameSession = gameSession.copyWith(players: players);
      } else {
        // TODO
      }
      _sendGameStatus();
    });
  }

  void _onGameStatusMessage(Map<String, dynamic> data) {
    var players = (data['players'] as List?)
            ?.map((player) => GamePlayerModel.fromJson(player))
            .toList() ??
        [];
    if (gameSession.players != null) {
      players = players
          .map((player) => player.copyWith(
              ready: (gameSession.players
                      ?.firstWhereOrNull((object) => object.id == player.id)
                      ?.ready ??
                  false)))
          .toList();
    }
    gameSession = gameSession.copyWith(players: players);
    _sendGameStatus();
  }

  void _onGameStartMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.lobby) {
        return;
      }
      _onGameStart?.call(data['deadline']);
      state = GameState.game;
    });
  }

  void _onTaskStartMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.game) {
        return;
      }
      _onTaskStart?.call(CurrentTaskModel.fromJson(data).toEntity());
    });
  }

  void _onTaskEndMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.game) {
        return;
      }
      _onTaskEnd?.call(TaskResultsModel.fromJson(data).toEntity());
    });
  }

  void _onPollStartMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.game) {
        return;
      }
      _onPollStart?.call(PollInfoModel.fromJson(data).toEntity());
    });
  }

  void _onGameEndMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.game) {
        return;
      }
      _clearSessionInfo();
      _onGameEnd?.call(GameResultsModel.fromJson(data).toEntity());
      state = GameState.finish;
    });
  }

  void _onJoinFailureMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state != GameState.start) {
        return;
      }
      joinCompleter?.complete(DataFailed(data['message'] ?? data['kind']));
      state = GameState.closed;
    });
  }

  void _onOpErrorMessage(Map<String, dynamic> data) {
    _onOpError?.call(data['message'] ?? data['kind']);
  }

  void _onConnectionClosed() async {
    await _stateLock.synchronized(() async {
      if (state == GameState.closed || state == GameState.finish) {
        state = GameState.closed;
        return;
      }
      joinCompleter?.complete(const DataFailed('connection closed'));
      _onGameInterrupted?.call('connection closed');
      state = GameState.closed;
    });
  }

  void _clearSessionInfo() {
    //_sessionRepository.clearSession();
  }

  void _onGameInterruptedMessage(Map<String, dynamic> data) async {
    await _stateLock.synchronized(() async {
      if (state == GameState.closed) {
        return;
      }
      //_channel?.sink.close();
      if (state == GameState.start) {
        joinCompleter?.complete(DataFailed(data['message'] ?? data['kind']));
        state = GameState.closed;
        return;
      }
      gameSession = GameSessionModel();
      _onGameInterrupted?.call(data['message'] ?? data['kind']);
      _clearSessionInfo();
      state = GameState.closed;
    });
  }

  Future<void> _delayedMessage(int delay, Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: delay));
    await _handleMessage(data);
  }

  Future<void> _handleMessage(Map<String, dynamic> data) async {
    final String kind = data['kind'];

    if (kind == 'game-status') {
      _onGameStatusMessage(data);
    } else if (kind == 'joined') {
      _onJoinedMessage(data);
    } else if (kind == 'waiting') {
      _onWaitingMessage(data);
    } else if (kind == 'game-start') {
      _onGameStartMessage(data);
    } else if (kind == 'task-start') {
      _onTaskStartMessage(data);
    } else if (kind == 'poll-start') {
      _onPollStartMessage(data);
    } else if (kind == 'task-end') {
      _onTaskEndMessage(data);
    } else if (kind == 'game-end') {
      _onGameEndMessage(data);
    } else if (kind == 'session-expired' ||
        kind == 'nickname-used' ||
        kind == 'lobby-full') {
      _onJoinFailureMessage(data);
    } else if (kind == 'op-only') {
      _onOpErrorMessage(data);
    }
  }

  void _listen() async {
    int taskResults = 10;
    int pollDuration = 10;

    await _delayedMessage(2, {
      'kind': 'joined',
      'msg-id': 1,
      'time': 1000,
      'player-id': 0,
      'session-id': 'AB8HJ7',
      'invite-code': 'AB8HJ7',
      'max-players': maxPlayers,
      'game': {
        'name': 'game name',
        'description': 'some text',
        'tasks': [
          {
            'name': 'Решите загадку',
            'description': '''Стоит дуб,
В нем двенадцать гнезд,
В каждом гнезде
По четыре яйца,
В каждом яйце
По семи цыпленков.''',
            'duration': {'kind': 'fixed', 'secs': 10},
            'type': 'checked-text'
          },
          {
            'name': 'Нарисуйте котика',
            'description': 'Просто рисуем кота. На скорость.',
            'duration': {'kind': 'fixed', 'secs': 30},
            'type': 'photo',
            'poll-duration': {'kind': 'fixed', 'secs': 8}
          },
        ]
      }
    });

    await _delayedMessage(1, {
      'kind': 'game-status',
      'msg-id': 2,
      'time': 6000,
      'players': [
        {'player-id': 1, 'nickname': nickname},
        {
          'player-id': 1,
          'nickname': 'Alex',
          'image':
              'https://gravatar.com/avatar/f79cc32d7f9cee4a094d1b1772c56d1c?s=400&d=robohash&r=x'
        }
      ]
    });

    await _delayedMessage(1, {
      'kind': 'waiting',
      'msg-id': 3,
      'time': 9000,
      'ready': [1]
    });

    await _delayedMessage(2, {
      'kind': 'game-status',
      'msg-id': 4,
      'time': 10000,
      'players': [
        {'player-id': 0, 'nickname': nickname},
        {
          'player-id': 1,
          'nickname': 'Alex',
          'image': // proto-violation
              'https://gravatar.com/avatar/f79cc32d7f9cee4a094d1b1772c56d1c?s=400&d=robohash&r=x'
        },
        {
          'player-id': 2,
          'nickname': 'James',
          'image': // proto-violation
              "https://robohash.org/f79cc32d7f9cee4a094d1b1772c56d1c?set=set4&bgset=&size=400x400"
        },
        {
          'player-id': 3,
          'nickname': 'Сладкая Дыня',
          'image': // proto-violation
              "https://robohash.org/63704034a6c7a8ce2ed2b9007faededa?set=set4&bgset=&size=400x400"
        },
      ]
    });

    await _delayedMessage(1, {
      'kind': 'waiting',
      'msg-id': 5,
      'time': 12000,
      'ready': [1, 2, 3, 4]
    });

    await Future.delayed(const Duration(seconds: 2));
    await _handleMessage({
      'kind': 'game-start',
      'deadline': DateTime.now().millisecondsSinceEpoch + 5000,
      'msg-id': 6,
      'time': 12000
    });
    await Future.delayed(const Duration(seconds: 5));

    int task1Duration = 10;
    await _handleMessage({
      'kind': 'task-start',
      'task-idx': 0,
      'deadline': DateTime.now().millisecondsSinceEpoch + task1Duration * 1000,
      'msg-id': 7,
      'time': 15000
    });
    await Future.delayed(Duration(seconds: task1Duration));

    await _handleMessage({
      'kind': 'task-end',
      'task-idx': 0,
      'deadline': DateTime.now().millisecondsSinceEpoch + taskResults * 1000,
      'msg-id': 8,
      'time': 17000,
      'scoreboard': [
        {'player-id': 0, 'task-points': 1, 'total-points': 1},
        {'player-id': 1, 'task-points': 0, 'total-points': 0},
        {'player-id': 2, 'task-points': 1, 'total-points': 1},
        {'player-id': 3, 'task-points': 0, 'total-points': 0}
      ],
      'answers': [
        {'value': 'year', 'player-count': 2, 'correct': true},
        {'value': 'облако в штанах', 'player-count': 2, 'correct': false},
        {'value': 'шампунь', 'player-count': 2, 'correct': false},
      ]
    });
    await Future.delayed(Duration(seconds: taskResults));

    int task2Duration = 15;
    await _handleMessage({
      'kind': 'task-start',
      'task-idx': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + task2Duration * 1000,
      'msg-id': 9,
      'time': 22000,
    });
    await Future.delayed(Duration(seconds: task2Duration));

    await _handleMessage({
      'kind': 'poll-start',
      'task-idx': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + pollDuration * 1000,
      'msg-id': 10,
      'time': 23000,
      'options': [
        'https://i.pinimg.com/736x/13/99/f4/1399f4bda826ac629f07277be6b2ba4e.jpg',
        'https://i.pinimg.com/originals/ea/29/cf/ea29cfe50fcab5d7dbff81c6bc300811.jpg',
        'https://i.pinimg.com/originals/f3/44/be/f344be7f01caece19afbcb613a2b0471.jpg'
      ]
    });
    await Future.delayed(Duration(seconds: pollDuration));

    await _handleMessage({
      'kind': 'task-end',
      'task-idx': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + taskResults * 1000,
      'msg-id': 11,
      'time': 24000,
      'scoreboard': [
        {'player-id': 0, 'task-points': 0, 'total-points': 1},
        {'player-id': 1, 'task-points': 0, 'total-points': 0},
        {'player-id': 2, 'task-points': 1, 'total-points': 2},
        {'player-id': 3, 'task-points': 0, 'total-points': 0}
      ],
      'answers': [
        {
          'value':
              'https://i.pinimg.com/736x/13/99/f4/1399f4bda826ac629f07277be6b2ba4e.jpg',
          'votes': 1
        },
        {
          'value':
              'https://i.pinimg.com/originals/ea/29/cf/ea29cfe50fcab5d7dbff81c6bc300811.jpg',
          'votes': 0
        },
        {
          'value':
              'https://i.pinimg.com/originals/f3/44/be/f344be7f01caece19afbcb613a2b0471.jpg',
          'votes': 2
        }
      ]
    });
    await Future.delayed(Duration(seconds: taskResults));

    await _handleMessage({
      'kind': 'game-end',
      'msg-id': 12,
      'time': 25000,
      'scoreboard': [
        {'player-id': 0, 'total-points': 4},
        {'player-id': 1, 'total-points': 2},
        {'player-id': 2, 'total-points': 3},
        {'player-id': 3, 'total-points': 1}
      ]
    });
    _onConnectionClosed();
  }

  @override
  Future<DataState<String>> startSession(Game game, Username username,
      {int maxPlayersCount = 20, bool requireReady = false}) async {
    uid = await uidGetter;
    String sessionId = 'ASSDIK';
    maxPlayers = maxPlayersCount;
    return joinSession(sessionId, username);

    return const DataFailed('cannot connect to server');
  }

  @override
  Future<DataState<String>> joinSession(
      String sessionId, Username username) async {
    uid = await uidGetter;
    debugPrint('device uid is $uid');
    gameSession = GameSessionModel();
    nickname = username.username;
    try {
      state = GameState.start;
      joinCompleter = Completer<DataState<String>>();
      _listen();
      _sendMesage('join', {'nickname': username.username});
    } catch (e) {
      return const DataFailed('cannot connect to server');
    }
    DataState<String> sid = await joinCompleter!.future;
    joinCompleter = null;
    return sid;
  }

  @override
  Future<DataState<String>> reconnectSession(String sessionId) async {
    uid = await uidGetter;
    debugPrint('device uid is $uid');
    gameSession = GameSessionModel();
    try {
      joinCompleter = Completer<DataState<String>>();
      _listen();
      _sendMesage('join', {'nickname': 'nickname'});
    } catch (e) {
      return const DataFailed('cannot connect to server');
    }
    DataState<String> sid = await joinCompleter!.future;
    joinCompleter = null;
    return sid;
  }

  void _sendMesage(String kind, Map<String, dynamic> body) async {
    body.addAll({
      'kind': kind,
      'time': DateTime.now().millisecondsSinceEpoch,
      'msg-id': await messageIdGenerator.newId
    });

    logger.d(jsonEncode(body));
  }

  @override
  void leaveSession() async {
    await _stateLock.synchronized(() async {
      if (state == GameState.closed) {
        return;
      }
      _sendMesage('leave', {});
      gameSession = GameSessionModel();
      state = GameState.closed;
    });
  }

  @override
  void kickPlayer(int playerId) {
    _sendMesage('kick', {'player-id': playerId});
  }

  @override
  void setReady(bool ready) {
    debugPrint('player set ready=$ready');
    _sendMesage('ready', {'ready': ready});
  }

  @override
  void sendAnswer(int taskId, Answer? answer, {bool? ready = false}) {
    if (answer == null) {
      debugPrint('player send answer: (ready=$ready, taskId=$taskId)');
      _sendMesage('task-answer', {'ready': ready, 'task-idx': taskId});
    } else if (answer is ImageTaskAnswer) {
      // load http
      debugPrint('player send answer HTTP IMAGE UPLOAD');
      debugPrint('player send answer: (ready=$ready, taskId=$taskId)');
      _sendMesage('task-answer', {'ready': ready, 'task-idx': taskId});
    } else {
      debugPrint('player send answer: (ready=$ready, taskId=$taskId)${{
        'answer': {'type': answer.taskType, 'value': answer.answer}
      }}');
      _sendMesage('task-answer', {
        'ready': ready,
        'task-idx': taskId,
        'answer': {'type': answer.taskType, 'value': answer.answer}
      });
    }
  }

  @override
  void sendPollChoice(int taskId, int? choice) {
    debugPrint('player send poll choice: (taskId=$taskId, choice=$choice)');
    _sendMesage('poll-choose', {'task-idx': taskId, 'option-idx': choice});
  }
  // callbacks

  @override
  void onGameStatus(Function(GameSession) callback) {
    _onGameStatus = callback;
    _sendGameStatus();
  }

  @override
  void onGameStart(Function(int?) callback) {
    _onGameStart = callback;
  }

  @override
  void onGameInterrupted(Function(String) callback) {
    _onGameInterrupted = callback;
  }

  @override
  void onOpError(Function(String) callback) {
    _onOpError = callback;
  }

  @override
  void onTaskStart(Function(CurrentTask) callback) {
    _onTaskStart = callback;
  }

  @override
  void onTaskEnd(Function(TaskResults) callback) {
    _onTaskEnd = callback;
  }

  @override
  void onGameEnd(Function(GameResults) callback) {
    _onGameEnd = callback;
  }

  @override
  void onPollStart(Function(PollInfo) callback) {
    _onPollStart = callback;
  }
}
