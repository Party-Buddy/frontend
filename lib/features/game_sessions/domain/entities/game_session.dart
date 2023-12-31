import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';

class GameSession {
  final String sessionId;
  final String invieCode;
  final String name;
  final String description;
  final String? imageUri;
  final int maxPlayersCount;
  final int? ownerId;
  final int? currentPlayerId;
  final List<GamePlayer> players;
  final List<TaskInfo> tasks;

  GameSession(
      {required this.sessionId,
      required this.invieCode,
      required this.name,
      required this.description,
      this.imageUri,
      required this.maxPlayersCount,
      this.ownerId,
      this.currentPlayerId,
      required this.players,
      required this.tasks});
}
