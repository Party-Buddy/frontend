import 'package:party_games_app/features/game_sessions/domain/entities/task_results.dart';

class TaskResultsModel {
  final int? index;
  final int? deadline;
  final List<PlayerResult>? scoreboard;
  final List<TaskAnswer>? answers;

  const TaskResultsModel({
    this.index,
    this.deadline,
    this.scoreboard,
    this.answers,
  });

  TaskResults toEntity() {
    return TaskResults(
        index: index ?? 0,
        deadline: deadline ?? 0,
        scoreboard: scoreboard ?? [],
        answers: answers ?? []);
  }

  factory TaskResultsModel.fromJson(Map<String, dynamic> map) {
    return TaskResultsModel(
      index: map['task-idx'],
      deadline: map['deadline'],
      scoreboard: (map['scoreboard'] as List?)
          ?.map((res) => PlayerResult(
              playerId: res['player-id'] ?? 0,
              score: res['task-points'] ?? 0,
              totalScore: res['total-points'] ?? 0))
          .toList(),
      answers: (map['answers'] as List?)
          ?.map((res) => TaskAnswer(
              value: res['value'] ?? '',
              score: res['votes'] ?? res['player-count'] ?? 0,
              correct: res['correct']))
          .toList(),
    );
  }
}
