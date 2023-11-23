import 'dart:convert';
import 'package:party_games_app/config/server/paths.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_player_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/game_session_model.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/username/domain/entities/username.dart';

class SessionEngineImpl implements SessionEngine {
  WebSocketChannel? _channel;
  Function(GameSession)? _onGameStatus;
  Function()? _onGameStart;
  GameSessionModel gameSession = GameSessionModel();

  void _sendGameStatus() {
    _onGameStatus?.call(gameSession.toEntity());
  }

  void _sendGameStart() {
    _onGameStart?.call();
  }

  void _onJoinedMessage(Map<String, dynamic> data) {
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
    gameSession = gameSession.copyWith(players: players);
    _sendGameStatus();
  }

  void _onGameStartMessage(Map<String, dynamic> data) {
    _sendGameStart();
  }

  void _listen() {
    _channel?.stream.listen((message) {
      final Map<String, dynamic> data = jsonDecode(message);
      final String kind = data['kind'];

      if (kind == 'gameStatus') {
        _onGameStatusMessage(data);
      } else if (kind == 'joined') {
        _onJoinedMessage(data);
      } else if (kind == 'waiting') {
        _onWaitingMessage(data);
      } else if (kind == 'gameStart') {
        _onGameStartMessage(data);
      }
    });
  }

  @override
  Future<DataState<void>> startSession(Game game, Username username) async {
    var response = await http.post(Uri.https(serverDomain, sessionPath),
        body: GameModel.fromEntity(game));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      String sessionId = jsonResponse['session-id'];
      // TODO img-requests: [] ImageRequestResponse field
      return joinSession(sessionId, username);
    } else {
      return DataFailed('Start game session code: ${response.statusCode}.');
    }
  }

  @override
  Future<DataState<void>> joinSession(String sessionId, Username username) async {
    gameSession = GameSessionModel();
    _channel = IOWebSocketChannel.connect(
        'ws://$serverDomain$sessionPath?${joinSessionParams[0]}=$sessionId');
    _listen();
    _sendMesage('join', {'nickname': username.username});
    return const DataSuccess(null);
  }

  void _sendMesage(String kind, Map<String,dynamic> body) {
    body.addAll({'kind': kind});
    _channel?.sink.add(jsonEncode(body));
  }

  @override
  void leaveSession() {
   _sendMesage('leave', {});
    _channel?.sink.close();
    gameSession = GameSessionModel();
  }

  @override
  void kickPlayer(int playerId) {
   _sendMesage('kick', {});
  }

  @override
  void setReady(bool ready) {
   _sendMesage('ready', {});
  }

  // callbacks

  @override
  void onGameStatus(Function(GameSession) callback) {
    _onGameStatus = callback;
    _sendGameStatus();
  }

  @override
  void onGameStart(Function() callback) {
    _onGameStart = callback;
  }
}
