import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_results.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/games/presentation/widgets/player_header.dart';

List<GamePlayer> playersMock = [
  const GamePlayer(
    id: 3,
    ready: false,
    name: "aiwannafly",
  ),
  const GamePlayer(
      id: 2,
      ready: false,
      name: "Alex",
      photoUrl:
          "https://gravatar.com/avatar/f79cc32d7f9cee4a094d1b1772c56d1c?s=400&d=robohash&r=x"),
  const GamePlayer(
      id: 1,
      ready: false,
      name: "James",
      photoUrl:
          "https://robohash.org/f79cc32d7f9cee4a094d1b1772c56d1c?set=set4&bgset=&size=400x400"),
  const GamePlayer(
      id: 0,
      ready: true,
      name: "Сладкая Дыня",
      photoUrl:
          "https://robohash.org/63704034a6c7a8ce2ed2b9007faededa?set=set4&bgset=&size=400x400"),
];

GameResults gameResultsMock() => GameResults(
        scoreboard: [
          PlayerFinalResult(playerId: 0, totalScore: 4),
          PlayerFinalResult(playerId: 1, totalScore: 3),
          PlayerFinalResult(playerId: 2, totalScore: 8),
          PlayerFinalResult(playerId: 3, totalScore: 12),
        ]);

class GameResultsScreenArguments {
  const GameResultsScreenArguments(
      {required this.gameName,
      required this.gameResults,
      required this.players});

  final String gameName;
  final GameResults gameResults;
  final List<GamePlayer> players;
}

class GameResultsScreen extends StatelessWidget {
  GameResultsScreen(
      {super.key,
      required this.gameName,
      required this.gameResults,
      required this.players}) {
    for (PlayerFinalResult result in gameResults.scoreboard) {
      scoreByPlayerId[result.playerId] = result.totalScore;
    }
    // reverse sort by score
    players.sort((p1, p2) =>
        -scoreByPlayerId[p1.id]!.compareTo(scoreByPlayerId[p2.id]!));

    winnerScoreThreshold = gameResults.scoreboard
        .map((result) => result.totalScore)
        .sorted((a, b) => a.compareTo(b))
        .reversed
        .take(_winnersCount)
        .min;
  }

  static const routeName = "/GameResults";
  static const _winnersCount = 3;

  final String gameName;
  final GameResults gameResults;
  final List<GamePlayer> players;
  final Map<int, int> scoreByPlayerId = {};
  late final int winnerScoreThreshold;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Итоги игры",
        showBackButton: false,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderWrapper(
                        borderColor: kPrimaryColor,
                        child: Text(
                          gameName,
                          style: defaultTextStyle(fontSize: 20),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: kPadding * 2),
                      child: Text(
                        "Очки",
                        style: defaultTextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: kPadding,
                ),
                Wrap(
                  spacing: kPadding,
                  runSpacing: kPadding,
                  children: players
                      .map((p) => PlayerHeader(
                            player: p,
                            points: scoreByPlayerId[p.id],
                            isWinner:
                                scoreByPlayerId[p.id]! >= winnerScoreThreshold,
                          ))
                      .toList(),
                )
              ],
            ),
            Column(
              children: [
                CustomButton(
                    text: "Выйти",
                    onPressed: () => Navigator.of(context)
                        .pushNamed(MainMenuScreen.routeName)),
                const SizedBox(
                  height: kPadding * 2,
                ),
                LinearTimer(
                  onTimerEnd: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, MainMenuScreen.routeName);
                  },
                  duration:
                      const Duration(seconds: 10),
                  color: kPrimaryColor,
                  backgroundColor: kAppBarColor,
                ),
              ],
            )
          ],
        ));
  }
}
