import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:party_games_app/config/server/paths.dart';
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
import 'package:party_games_app/features/game_sessions/domain/repository/session_data_repository.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_uid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';

class SessionEngineImpl implements SessionEngine {
  Function(GameSession)? _onGameStatus;
  Function(int?)? _onGameStart;
  Function(String)? _onGameInterrupted;
  Function(String)? _onJoinFailure;
  Function(String)? _onOpError;
  Function(CurrentTask)? _onTaskStart;
  Function(TaskResults)? _onTaskEnd;
  Function(PollInfo)? _onPollStart;
  Function(GameResults)? _onGameEnd;

  WebSocketChannel? _channel;
  late final Future<String> uidGetter;
  late final SessionRepository _sessionRepository;
  String? uid;
  GameSessionModel gameSession = GameSessionModel();
  SyncCounter messageIdGenerator = SyncCounter();
  Completer<DataState<String>>? joinCompleter;

  SessionEngineImpl(
      GetUIDUseCase getUIDUseCase, SessionRepository sessionRepository) {
    uidGetter = getUIDUseCase.call();
    _sessionRepository = sessionRepository;
  }

  void _sendGameStatus() {
    _onGameStatus?.call(gameSession.toEntity());
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
    _onTaskEnd?.call(TaskResultsModel.fromJson(data).toEntity());
  }

  void _onGameEndMessage(Map<String, dynamic> data) {
    _clearSessionInfo();
    _onGameEnd?.call(GameResultsModel.fromJson(data).toEntity());
  }

  void _onPollStartMessage(Map<String, dynamic> data) {
    _onPollStart?.call(PollInfoModel.fromJson(data).toEntity());
  }

  void _onJoinFailureMessage(Map<String, dynamic> data) {
    joinCompleter?.complete(DataFailed(data['message'] ?? data['kind']));
    _onJoinFailure?.call(data['message'] ?? data['kind']);
  }

  void _onOpErrorMessage(Map<String, dynamic> data) {
    _onOpError?.call(data['message'] ?? data['kind']);
  }

  void _onConnectionClosed() {
    joinCompleter?.complete(const DataFailed('connection closed'));
  }

  void _clearSessionInfo(){
    _sessionRepository.clearSession();
  }

  void _onGameInterruptedMessage(Map<String, dynamic> data) {
    if (joinCompleter != null) {
      joinCompleter?.complete(const DataFailed('connection closed'));
    } else {
      _clearSessionInfo();
      _onGameInterrupted?.call(data['message'] ?? data['kind']);
    }
  }

  void _listen() {
    _channel?.stream.listen((message) {
      final Map<String, dynamic> data = jsonDecode(message);
      final String? kind = data['kind'];
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
      } else if (kind == 'internal' ||
          kind == 'malformed-msg' ||
          kind == 'proto-violation' ||
          kind == 'reconnected' ||
          kind == 'inactivity' ||
          kind == 'session-closed') {
        _onGameInterruptedMessage(data);
      }
    }, onDone: () {
      _onConnectionClosed();
    });
  }

  @override
  Future<DataState<String>> startSession(
      Game game, Username username, int maxPlayersCount) async {
    uid = await uidGetter;
    try {
      var bodyJson = <String, dynamic>{
        'game-type': 'public',
        'game-id': '11112222-3333-4444-5555-131072262144',
        'player-count': maxPlayersCount,
        'require-ready': false
      };
      var response = await http
          .post(Uri.http('$serverDomain:$serverHttpPort', sessionPath),
              headers: <String, String>{
                'Authorization': 'Bearer $uid',
                'Content-type': 'application/json'
              },
              body: jsonEncode(bodyJson))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String sessionId = jsonResponse['invite-code'];
        // TODO img-requests: [] ImageRequestResponse field
        return joinSession(sessionId, username);
      } else {
        return DataFailed(
            'Ошибка при создании сессии: ${response.statusCode}.');
      }
    } catch (e) {
      return const DataFailed('Сервер недоступен');
    }
  }

  @override
  Future<DataState<String>> joinSession(
      String inviteCode, Username username) async {
    gameSession = GameSessionModel();
    uid = await uidGetter;
    try {
      _channel = IOWebSocketChannel.connect(
          'ws://$serverDomain:$serverWsPort$sessionPath?${joinSessionParams[1]}=$inviteCode',
          headers: <String, String>{'Authorization': 'Bearer $uid'},
          protocols: ['websocket'],
          connectTimeout: const Duration(seconds: 5));
      joinCompleter = Completer<DataState<String>>();
      _listen();
      _sendMesage('join', {'nickname': username.username});
    } catch (e) {
      return const DataFailed('cannot connect to server');
    }
    DataState<String> sid = await joinCompleter!.future;
    joinCompleter = null;
    if (sid.error != null) {
      return DataFailed(sid.error!);
    } else {
      _sessionRepository.saveSession(sid.data!);
      return DataSuccess(inviteCode);
    }
  }

  @override
  Future<DataState<String>> reconnectSession(String sessionId) async {
    gameSession = GameSessionModel();
    uid = await uidGetter;
    try {
      _channel = IOWebSocketChannel.connect(
          'ws://$serverDomain:$serverWsPort$sessionPath?${joinSessionParams[0]}=$sessionId',
          headers: <String, String>{'Authorization': 'Bearer $uid'},
          protocols: ['websocket'],
          connectTimeout: const Duration(seconds: 5));
      joinCompleter = Completer<DataState<String>>();
      _listen();
      _sendMesage('join', {'nickname': 'nickname'});
    } catch (e) {
      return const DataFailed('cannot connect to server');
    }
    DataState<String> sid = await joinCompleter!.future;
    joinCompleter = null;
    if (sid.error != null) {
      return DataFailed(sid.error!);
    } else {
      return const DataSuccess('UNKNOWN');
    }
  }

  void _sendMesage(String kind, Map<String, dynamic> body) async {
    body.addAll({
      'kind': kind,
      'time': DateTime.now().millisecondsSinceEpoch,
      'msg-id': await messageIdGenerator.newId
    });
    _channel?.sink.add(jsonEncode(body));
    print(jsonEncode(body));
    print('');
  }

  @override
  void leaveSession() {
    _sendMesage('leave', {});
    _channel?.sink.close();
    gameSession = GameSessionModel();
  }

  @override
  void kickPlayer(int playerId) {
    _sendMesage('kick', {'player-id': playerId});
  }

  @override
  void setReady(bool ready) {
    _sendMesage('ready', {'ready': ready});
  }

  @override
  void sendAnswer(
    bool ready,
    int taskId,
  ) {
    _sendMesage('task-answer', {
      'ready': ready,
      'task-idx': taskId,
      'answer': {'type': 'text', 'value': 'answer'}
    });
  }

  @override
  void sendPollChoice(bool ready, int taskId, int choice) {
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
