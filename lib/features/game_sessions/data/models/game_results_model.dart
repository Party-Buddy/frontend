import 'package:party_games_app/features/game_sessions/domain/entities/game_results.dart';

class GameResultsModel {
  final List<PlayerFinalResult>? scoreboard;

  const GameResultsModel({
    this.scoreboard
  });

  GameResults toEntity() {
    return GameResults(
        scoreboard: scoreboard ?? []);
  }

  factory GameResultsModel.fromJson(Map<String, dynamic> map) {
    return GameResultsModel(
      scoreboard: (map['scoreboard'] as List?)
          ?.map((res) => PlayerFinalResult(
              playerId: res['player-id'] ?? 0,
              totalScore: res['total-points'] ?? 0))
          .toList()
    );
  }
}
