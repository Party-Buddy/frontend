import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';

class GameSession {
  final String sessionId;
  final String name;
  final String description;
  final String? imageUri;
  final int maxPlayersCount;
  final int? ownerId;
  final int? currentPlayerId;
  final List<GamePlayer> players;

  GameSession(
      {required this.sessionId,
      required this.name,
      required this.description,
      this.imageUri,
      required this.maxPlayersCount,
      this.ownerId,
      this.currentPlayerId,
      required this.players});
}
