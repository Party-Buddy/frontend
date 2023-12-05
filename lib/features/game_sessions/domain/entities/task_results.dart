class PlayerResult {
  final int playerId;
  final int score;
  final int totalScore;

  PlayerResult(
      {required this.playerId, required this.score, required this.totalScore});
}

class TaskAnswer {
  final String value;
  final int score;
  final bool? correct;

  TaskAnswer({required this.value, required this.score, required this.correct});
}

class TaskResults {
  final int index;
  final int deadline;
  final List<PlayerResult> scoreboard;
  final List<TaskAnswer> answers;

  TaskResults(
      {required this.index,
      required this.deadline,
      required this.scoreboard,
      required this.answers});
}
