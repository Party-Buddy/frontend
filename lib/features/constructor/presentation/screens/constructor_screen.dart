import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/resources/source_enum.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/core/widgets/dropdown_button.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/constructor/presentation/screens/game_create_screen.dart';
import 'package:party_games_app/features/constructor/presentation/screens/task_create_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_info_screen.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_list.dart';
import 'package:party_games_app/features/tasks/presentation/screens/task_info_screen.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_list.dart';

enum ObjectType { task, game }

enum SortType { date, type }

class ConstructorScreen extends StatelessWidget {
  ConstructorScreen({super.key});

  static const routeName = "/Constructor";

  final currObjNotifier = ValueNotifier(ObjectType.game);
  final currSourceNotifier = ValueNotifier(Source.owned);

  double get labelWidth => 300.0;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBarTitle: "Конструктор",
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ValueListenableBuilder(
            valueListenable: currObjNotifier,
            builder: (context, value, child) => Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: kPadding / 2),
                    alignment: Alignment.center,
                    width: labelWidth,
                    child: OptionSwitcher(
                        options: ObjectType.values,
                        onTap: (o) => currObjNotifier.value = o,
                        initialOption: currObjNotifier.value,
                        stringMapper: (o) =>
                            o == ObjectType.game ? "Игры" : "Задания"),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: currSourceNotifier,
            builder: (context, value, child) => Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: kPadding / 2),
                    alignment: Alignment.center,
                    width: labelWidth,
                    child: OptionSwitcher(
                        options: Source.values,
                        onTap: (o) => currSourceNotifier.value = o,
                        initialOption: currSourceNotifier.value,
                        stringMapper: (o) =>
                            o == Source.owned ? "Свои" : "Каталог"),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: Expanded(
              child: SizedBox(
                width: labelWidth,
                child: Row(
                  children: [
                    Text(
                      "Сортировать",
                      style: defaultTextStyle(),
                    ),
                    const SizedBox(
                      width: kPadding,
                    ),
                    SizedBox(
                      width: 100,
                      child: CustomDropDownButton(
                          initialItem: SortType.date,
                          items: SortType.values,
                          stringMapper: (t) => switch (t) {
                                SortType.date => "По дате",
                                SortType.type => "По типу"
                              },
                          onChanged: (s) {}),
                    ),
                    const SizedBox(
                      width: kPadding,
                    ),
                    CustomIconButton(
                        onPressed: () => {},
                        iconData:
                            false ? Icons.arrow_downward : Icons.arrow_upward)
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: currObjNotifier,
            builder: (context, value, child) => Expanded(
              flex: 8,
              child: currObjNotifier.value == ObjectType.game
                  ? ValueListenableBuilder(
                      valueListenable: currSourceNotifier,
                      builder: (context, value, child) =>
                          buildGameList(context, onTapOnGame: (game) {
                        Navigator.pushNamed(context, GameInfoScreen.routeName,
                            arguments: GameInfoScreenArguments(game: game));
                      }, source: currSourceNotifier.value),
                    )
                  : ValueListenableBuilder(
                      valueListenable: currSourceNotifier,
                      builder: (context, value, child) => buildTaskList(
                          onTapOnTask: (task) {
                            Navigator.pushNamed(
                                context, TaskInfoScreen.routeName,
                                arguments: TaskInfoScreenArguments(task: task));
                          },
                          source: currSourceNotifier.value)),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                  valueListenable: currObjNotifier,
                  builder: (context, value, child) => CustomButton(
                      text: value == ObjectType.game
                          ? "Создать игру"
                          : "Создать задание",
                      onPressed: () =>
                          Navigator.pushNamed(context, TaskCreateScreen.routeName)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
