import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_results.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/poll_info.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_answer.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_results.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';

abstract class SessionEngine {
  Future<DataState<String>> startSession(Game game, Username username,
      {int maxPlayersCount = 20, bool requireReady = false});
  Future<DataState<String>> joinSession(String inviteCode, Username username);
  Future<DataState<String>> reconnectSession(String sessionId);

  void leaveSession();
  void kickPlayer(int playerId);
  void setReady(bool ready);
  void sendAnswer(int taskId, Answer? answer, {bool? ready = false});
  void sendPollChoice(int taskId, int? choice);

  // callbacks
  void onGameStatus(Function(GameSession) callback);
  void onGameStart(Function(int?) callback);
  void onTaskStart(Function(CurrentTask) callback);
  void onPollStart(Function(PollInfo) callback);
  void onTaskEnd(Function(TaskResults) callback);
  void onGameEnd(Function(GameResults) callback);
  // failure callbacks
  void onOpError(Function(String) callback);
  void onGameInterrupted(Function(String) callback);
}

enum GameState { start, lobby, game, finish, closed }
