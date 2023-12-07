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
import 'package:party_games_app/features/game_sessions/domain/entities/task_results.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_uid.dart';

class SessionEngineTestImpl implements SessionEngine {
  late final Future<String> uidGetter;
  String? uid;

  Function(GameSession)? _onGameStatus;
  Function(int?)? _onGameStart;
  Function(String)? _onGameInterrupted;
  Function(String)? _onJoinFailure;
  Function(String)? _onOpError;
  Function(CurrentTask)? _onTaskStart;
  Function(TaskResults)? _onTaskEnd;
  Function(PollInfo)? _onPollStart;
  Function(GameResults)? _onGameEnd;
  GameSessionModel gameSession = GameSessionModel();
  SyncCounter messageIdGenerator = SyncCounter();
  String nickname = 'Your nickname';
  int maxPlayers = maxPlayersCount;
  var logger = Logger();
  Completer<DataState<String>>? joinCompleter;

  SessionEngineTestImpl() {
    uidGetter = GetIt.instance<GetUIDUseCase>().call();
  }

  void _sendGameStatus() {
    _onGameStatus?.call(gameSession.toEntity());
  }

  void _sendJoinFailure(String msg) {
    _onJoinFailure?.call(msg);
  }

  void _onJoinedMessage(Map<String, dynamic> data) {
    joinCompleter?.complete(DataSuccess(data['session-id'] ?? ''));
    gameSession = GameSessionModel.fromJson(data);
    _sendGameStatus();
  }

  void _onWaitingMessage(Map<String, dynamic> data) {
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

  void _onGameStartMessage(Map<String, dynamic> data) {
    _onGameStart?.call(data['deadline']);
  }

  void _onTaskStartMessage(Map<String, dynamic> data) {
    _onTaskStart?.call(CurrentTaskModel.fromJson(data).toEntity());
  }

  void _onTaskEndMessage(Map<String, dynamic> data) {
    var tr = TaskResultsModel.fromJson(data).toEntity();
    _onTaskEnd?.call(tr);
  }

  void _onGameEndMessage(Map<String, dynamic> data) {
    var gr = GameResultsModel.fromJson(data).toEntity();
    _onGameEnd?.call(gr);
  }

  void _onPollStartMessage(Map<String, dynamic> data) {
    var pi = PollInfoModel.fromJson(data).toEntity();
    _onPollStart?.call(pi);
  }

  void _onJoinFailureMessage(Map<String, dynamic> data) {
    joinCompleter?.complete(DataFailed(data['message'] ?? data['kind']));
    _sendJoinFailure(data['message'] ?? data['kind']);
  }

  void _onOpErrorMessage(Map<String, dynamic> data) {
    _onOpError?.call(data['message'] ?? data['kind']);
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
    await _delayedMessage(2, {
      'kind': 'joined',
      'msg-id': 1,
      'time': 1000,
      'player-id': 1,
      'session-id': 'AB8HJ7',
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
          'player-id': 2,
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
        {'player-id': 1, 'nickname': nickname},
        {
          'player-id': 2,
          'nickname': 'Alex',
          'image': // proto-violation
              'https://gravatar.com/avatar/f79cc32d7f9cee4a094d1b1772c56d1c?s=400&d=robohash&r=x'
        },
        {
          'player-id': 3,
          'nickname': 'James',
          'image': // proto-violation
              "https://robohash.org/f79cc32d7f9cee4a094d1b1772c56d1c?set=set4&bgset=&size=400x400"
        },
        {
          'player-id': 4,
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

    await _delayedMessage(1, {
      'kind': 'game-start',
      'deadline': DateTime.now().millisecondsSinceEpoch + 5000,
      'msg-id': 6,
      'time': 12000
    });

    await _delayedMessage(5, {
      'kind': 'task-start',
      'task-idx': 0,
      'deadline': DateTime.now().millisecondsSinceEpoch + 10000,
      'msg-id': 7,
      'time': 15000
    });

    await _delayedMessage(10, {
      'kind': 'task-end',
      'task-idx': 0,
      'deadline': DateTime.now().millisecondsSinceEpoch + 5000,
      'msg-id': 8,
      'time': 17000,
      'scoreboard': [
        {'player-id': 0, 'task-points': 1, 'total-points': 1},
        {'player-id': 1, 'task-points': 0, 'total-points': 0},
        {'player-id': 2, 'task-points': 1, 'total-points': 1},
        {'player-id': 3, 'task-points': 0, 'total-points': 0}
      ],
      'answers': [
        {'value': 'the correct one', 'player-count': 2, 'correct': true},
        {'value': 'wrong!', 'player-count': 2, 'correct': false}
      ]
    });

    await _delayedMessage(5, {
      'kind': 'task-start',
      'task-idx': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + 30000,
      'msg-id': 9,
      'time': 22000,
    });

    await _delayedMessage(30, {
      'kind': 'poll-start',
      'index': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + 5000,
      'msg-id': 10,
      'time': 23000,
      'options': [
        'https://i.pinimg.com/736x/13/99/f4/1399f4bda826ac629f07277be6b2ba4e.jpg',
        'https://sun9-8.userapi.com/impg/lSJGYXohgBrdZtSLEW0x6RFPgL9c7hkzLl8G4A/SiCq0z2kO5w.jpg?size=1440x1440&quality=95&sign=39ae4e4ecd33a495b4ea5a095667bebe&c_uniq_tag=xxP_8FQHcoaN5BhRFL9l-lLnVCz3fDWM6qMbn9parik&type=album',
        'https://yt3.ggpht.com/ytc/AKedOLRIBpbC4usga9kP1bzA_LPp2wMeb6kmsLodIrMG=s900-c-k-c0x00ffffff-no-rj'
      ]
    });

    await _delayedMessage(5, {
      'kind': 'task-end',
      'task-idx': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + 5000,
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
              'https://sun9-8.userapi.com/impg/lSJGYXohgBrdZtSLEW0x6RFPgL9c7hkzLl8G4A/SiCq0z2kO5w.jpg?size=1440x1440&quality=95&sign=39ae4e4ecd33a495b4ea5a095667bebe&c_uniq_tag=xxP_8FQHcoaN5BhRFL9l-lLnVCz3fDWM6qMbn9parik&type=album',
          'votes': 0
        },
        {
          'value':
              'https://yt3.ggpht.com/ytc/AKedOLRIBpbC4usga9kP1bzA_LPp2wMeb6kmsLodIrMG=s900-c-k-c0x00ffffff-no-rj',
          'votes': 2
        }
      ]
    });

    await _delayedMessage(5, {
      'kind': 'game-end',
      'msg-id': 12,
      'time': 25000,
      'scoreboard': [
        {'player-id': 0, 'total-points': 1},
        {'player-id': 1, 'total-points': 0},
        {'player-id': 2, 'total-points': 2},
        {'player-id': 3, 'total-points': 0}
      ]
    });
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
  void leaveSession() {
    _sendMesage('leave', {});
    gameSession = GameSessionModel();
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
  void sendAnswer(bool ready, int taskId) {
    debugPrint(
        'player send answer: (ready=$ready,taskId=$taskId, TODO answer)');
    _sendMesage('task-answer', {
      'ready': ready,
      'task-idx': taskId,
      'answer': {'type': 'text', 'value': 'answer'}
    });
  }

  @override
  void sendPollChoice(bool ready, int taskId, int choice) {
    debugPrint(
        'player send poll choice: (ready=$ready,taskId=$taskId, choice=$choice)');
    _sendMesage('poll-choose',
        {'task-idx': taskId, 'option-idx': ready ? choice : null});
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
  void onJoinFailure(Function(String) callback) {
    _onJoinFailure = callback;
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
