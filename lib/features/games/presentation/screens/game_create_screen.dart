import 'package:flutter/material.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/labeled_slider.dart';
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

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgorundColor,
        appBar: AppBar(
          leading: backButton(context),
          title: const Text("Создание новой игры"),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: kBackgroundGradient),
          padding: const EdgeInsets.all(kPadding * 2),
          alignment: Alignment.center,
          child: Column(
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
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: kBorderRadius, border: border()),
                        padding: const EdgeInsets.all(12),
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
                  InkWell(
                    onTap: () => showWidget(context, GameList(onTapOnGame: (_) {})),
                    child: GameHeader(
                        game: Game(
                          id: 1,
                          name: "Minecraft",
                          imageId: "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
                          tasks: [const CheckedTextTask(
                            id: 1,
                            name:"Basics1",
                            description: "what is the max stack size for swords?",
                            duration: 10,
                            answer: "1"),],
                            lastModifiedTime: DateTime.now().millisecondsSinceEpoch)),
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
                      onPressed: () => showMessage(context, "Еще делаем :)")),
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
        ));
  }
}
