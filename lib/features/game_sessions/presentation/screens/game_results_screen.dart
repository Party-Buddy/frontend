import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/games/presentation/widgets/player_header.dart';

class GameResults {
  final String gameName;
  final List<GamePlayer> players;
  final Map<int, int> scoreByPlayerId;
  final int winnerScoreThreshold;

  GameResults(
      {required this.gameName,
      required this.players,
      required this.scoreByPlayerId,
      required this.winnerScoreThreshold});
}

final gameResultsMock = GameResults(
    gameName: "Minecraft Quiz",
    players: [
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
    ],
    scoreByPlayerId: {0: 2, 1: 4, 2: 7, 3: 11},
    winnerScoreThreshold: 4);

class GameResultsScreenArguments {
  const GameResultsScreenArguments({required this.gameResults});

  final GameResults gameResults;
}

class GameResultsScreen extends StatelessWidget {
  const GameResultsScreen({super.key, required this.gameResults});

  static const routeName = "/GameResults";

  final GameResults gameResults;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Итоги игры",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderWrapper(
                        border: Border.all(color: kPrimaryColor),
                        child: Text(
                          gameResults.gameName,
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
                  children: gameResults.players
                      .map((p) => PlayerHeader(
                            player: p,
                            points: gameResults.scoreByPlayerId[p.id],
                            isWinner: gameResults.scoreByPlayerId[p.id]! >=
                                gameResults.winnerScoreThreshold,
                          ))
                      .toList(),
                )
              ],
            ),
            CustomButton(
                text: "Выйти",
                onPressed: () =>
                    Navigator.of(context).pushNamed(MainMenuScreen.routeName))
          ],
        ));
  }
}
