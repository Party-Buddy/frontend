class PlayerFinalResult {
  final int playerId;
  final int totalScore;

  PlayerFinalResult({required this.playerId, required this.totalScore});
}

class GameResults {
  final int index;
  final int deadline;
  final List<PlayerFinalResult> scoreboard;

  GameResults(
      {required this.index, required this.deadline, required this.scoreboard});
}
