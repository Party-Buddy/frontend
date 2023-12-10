class PlayerFinalResult {
  final int playerId;
  final int totalScore;

  PlayerFinalResult({required this.playerId, required this.totalScore});
}

class GameResults {
  final List<PlayerFinalResult> scoreboard;

  GameResults(
      {required this.scoreboard});
}
