import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/username/domain/entities/username.dart';

abstract class SessionEngine {
  Future<DataState<void>> startSession(Game game, Username username);
  Future<DataState<void>> joinSession(String sessionId, Username username);

  void leaveSession();
  void kickPlayer(int playerId);
  void setReady(bool ready);

  // callbacks
  void onGameStatus(Function(GameSession) callback);
  void onGameStart(Function() callback);
}
