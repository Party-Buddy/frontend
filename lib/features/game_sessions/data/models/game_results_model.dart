import 'package:party_games_app/features/game_sessions/domain/entities/game_results.dart';

class GameResultsModel {
  final int? index;
  final int? deadline;
  final List<PlayerFinalResult>? scoreboard;

  const GameResultsModel({
    this.index,
    this.deadline,
    this.scoreboard
  });

  GameResults toEntity() {
    return GameResults(
        index: index ?? 0,
        deadline: deadline ?? 0,
        scoreboard: scoreboard ?? []);
  }

  factory GameResultsModel.fromJson(Map<String, dynamic> map) {
    return GameResultsModel(
      index: map['task-idx'],
      deadline: map['deadline'],
      scoreboard: (map['scoreboard'] as List?)
          ?.map((res) => PlayerFinalResult(
              playerId: res['player-id'] ?? 0,
              totalScore: res['total-points'] ?? 0))
          .toList()
    );
  }
}
