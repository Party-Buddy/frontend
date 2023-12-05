import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:party_games_app/config/consts.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/utils/sync_counter.dart';
import 'package:party_games_app/features/game_sessions/data/models/current_task_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_player_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_session_model.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/username/domain/entities/username.dart';

class SessionEngineTestImpl implements SessionEngine {
  Function(GameSession)? _onGameStatus;
  Function(int?)? _onGameStart;
  Function(String)? _onGameInterrupted;
  Function(String)? _onJoinFailure;
  Function(String)? _onOpError;
  Function(CurrentTask)? _onTaskStart;
  GameSessionModel gameSession = GameSessionModel();
  SyncCounter messageIdGenerator = SyncCounter();
  String nickname = 'Your nickname';
  int maxPlayers = maxPlayersCount;
  var logger = Logger();
  Completer<DataState<String>> joinCompleter = Completer<DataState<String>>();

  void _sendGameStatus() {
    _onGameStatus?.call(gameSession.toEntity());
  }

  void _sendJoinFailure(String msg) {
    _onJoinFailure?.call(msg);
  }

  void _onJoinedMessage(Map<String, dynamic> data) {
    joinCompleter.complete(DataSuccess(data['session-id'] ?? ''));
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

  void _onJoinFailureMessage(Map<String, dynamic> data) {
    joinCompleter.complete(DataFailed(data['message'] ?? data['kind']));
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
            'name': 'Сфотографируйте банковскую карту',
            'description': 'Проведем голосование на самую красивую карту. Желательно фотать с обратной стороны.',
            'duration': 30,
            'type': 'photo',
            'poll-duration': {'kind': 'fixed', 'secs': 10}
          },
          {
            'name': 'Ввести пароль от всех аккаунтов',
            'description': 'В рамках данной задачи нужно ввести ваш пароль от всех аккаунтов, чтобы оценить, насколько он надежный.',
            'duration': 30,
            'type': 'checked-text'
          }
        ]
      }
    });

    await _delayedMessage(0, {
      'kind': 'game-status',
      'msg-id': 2,
      'time': 6000,
      'players': [
        {'player-id': 1, 'nickname': nickname},
        {'player-id': 2, 'nickname': 'player 2'}
      ]
    });

    await _delayedMessage(2, {
      'kind': 'waiting',
      'msg-id': 3,
      'time': 9000,
      'ready': [1]
    });

    await _delayedMessage(3, {
      'kind': 'game-status',
      'msg-id': 4,
      'time': 10000,
      'players': [
        {'player-id': 1, 'nickname': nickname},
        {'player-id': 2, 'nickname': 'player 2'},
        {'player-id': 3, 'nickname': 'player 3'}
      ]
    });

    await _delayedMessage(1, {
      'kind': 'waiting',
      'msg-id': 5,
      'time': 12000,
      'ready': [1, 2, 3]
    });

    await _delayedMessage(0, {
      'kind': 'game-start',
      'deadline': DateTime.now().millisecondsSinceEpoch + 12000,
      'msg-id': 3,
      'time': 12000
    });

    await _delayedMessage(0, {
      'kind': 'task-start',
      'task-idx': 0,
      'deadline': DateTime.now().millisecondsSinceEpoch + 30000,
      'msg-id': 6,
      'time': 15000
    });

    await _delayedMessage(10, {
      'kind': 'task-start',
      'task-idx': 1,
      'deadline': DateTime.now().millisecondsSinceEpoch + 30000,
      'msg-id': 7,
      'time': 15000
    });
  }

  @override
  Future<DataState<String>> startSession(Game game, Username username, int maxPlayersCount) async {
    String sessionId = 'ASSDIK';
    maxPlayers = maxPlayersCount;
    return joinSession(sessionId, username);

    return const DataFailed('cannot connect to server');
  }

  @override
  Future<DataState<String>> joinSession(
      String sessionId, Username username) async {
    gameSession = GameSessionModel();
    nickname = username.username;
    try {
      joinCompleter = Completer<DataState<String>>();
      _listen();
      _sendMesage('join', {'nickname': username.username});
    } catch (e) {
      return const DataFailed('cannot connect to server');
    }
    DataState<String> sid = await joinCompleter.future;
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
}
