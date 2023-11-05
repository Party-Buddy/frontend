import 'package:flutter/material.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/labeled_slider.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/waiting_room_screen.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_list.dart';
import 'package:party_games_app/features/players/domain/usecases/select_nickname.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/core/widgets/button.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_header.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/config/theme/commons.dart';

class GameStartScreen extends StatefulWidget {
  const GameStartScreen({super.key});

  static const routeName = "/GameStart";

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  Game game = Game(
      id: 1,
      name: "Minecraft",
      imageUri:
          "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
      tasks: [
        const CheckedTextTask(
            id: 1,
            name: "Basics1",
            description: "what is the max stack size for swords?",
            duration: 10,
            answer: "1"),
      ],
      updatedAt: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBarTitle: "Начать игру",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: kPadding,
              ),
              Row(
                children: [
                  Flexible(
                    child: SingleLineInputLabel(
                        labelText: "Ваш никнейм",
                        onSubmitted: (s) {
                          if (validateNickname(s)) {
                            return SubmitResult.success;
                          }
                          showMessage(context, nicknameRequirements);
                          return SubmitResult.error;
                        }),
                  ),
                  const SizedBox(
                    width: kPadding,
                  ),
                  BorderWrapper(
                    padding: kPadding * 1.35,
                    child: Icon(
                      Icons.person_2,
                      size: 30,
                      color: kBorderColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              GameHeader(
                game: game,
                onTap: () => showWidget(
                    context,
                    content: GameList(
                        onTapOnGame: (selectedGame) => setState(() {
                              Navigator.pop(context);
                              game = selectedGame;
                            }))),
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              BorderWrapper(
                  child: LabeledSlider(
                      min: minPlayersCount,
                      max: maxPlayersCount,
                      initial: minPlayersCount,
                      onChanged: (_) {},
                      displayValue: (playersCount) =>
                          "Количество игроков: $playersCount")),
            ],
          ),
          Column(
            children: [
              CustomButton(
                  text: "Продолжить",
                  onPressed: () => Navigator.pushNamed(
                      context, WaitingRoomScreen.routeName,
                      arguments: const WaitingRoomScreenArguments(
                          players: playersMock, gameSession: gameSessionMock))),
              const SizedBox(
                height: kPadding,
              ),
              CustomButton(
                  text: "Выйти",
                  onPressed: () => Navigator.pushNamed(context, "/"))
            ],
          )
        ],
      ),
    );
  }
}
