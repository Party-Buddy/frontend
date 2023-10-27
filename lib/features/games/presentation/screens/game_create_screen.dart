import 'package:flutter/material.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/players/domain/usecases/select_nickname.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/core/widgets/button.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_header.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/config/theme/commons.dart';

class GameCreateScreen extends StatefulWidget {
  const GameCreateScreen({super.key});

  @override
  State<GameCreateScreen> createState() => _GameCreateScreenState();
}

class _GameCreateScreenState extends State<GameCreateScreen> {
  final playersCount = ValueNotifier(2);

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
          decoration: const BoxDecoration(gradient: kBackgroundGradient),
          padding: const EdgeInsets.all(20.0),
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
                        child: const Icon(
                          Icons.person_2,
                          size: 30,
                          color: Color.fromARGB(255, 230, 40, 255),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kPadding * 2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: GameHeader(
                        game: Game(
                            name: "Minecraft",
                            photoUrl:
                                "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
                            tasks: [Task(), Task()])),
                  ),
                  const SizedBox(
                    height: kPadding * 2,
                  ),
                  borderWrapper(
                      ValueListenableBuilder(
                          valueListenable: playersCount,
                          builder: (context, value, child) => Column(
                                children: [
                                  borderWrapper(Text(
                                    "Количество игроков: ${playersCount.value}",
                                    style: standardTextStyle(),
                                  )),
                                  const SizedBox(
                                    height: kPadding,
                                  ),
                                  Slider(
                                      activeColor:
                                          Color.fromARGB(255, 185, 3, 172),
                                      thumbColor:
                                          Color.fromARGB(255, 208, 0, 194),
                                      inactiveColor:
                                          Color.fromARGB(255, 72, 48, 86),
                                      value: value.toDouble(),
                                      min: 2,
                                      max: 12,
                                      onChanged: (newVal) =>
                                          playersCount.value = newVal.round())
                                ],
                              )),
                      padding: kPadding)
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
