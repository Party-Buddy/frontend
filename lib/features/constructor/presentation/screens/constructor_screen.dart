import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/core/widgets/dropdown_button.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/constructor/presentation/screens/game_create_screen.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_list.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_list.dart';

class ConstructorScreen extends StatefulWidget {
  const ConstructorScreen({super.key});

  static const routeName = "/Constructor";

  @override
  State<ConstructorScreen> createState() => _ConstructorScreenState();
}

enum ObjectType { task, game }

enum SortType { date, type }

class _ConstructorScreenState extends State<ConstructorScreen> {
  ObjectType currObjType = ObjectType.game;
  Source currSource = Source.owned;
  bool descending = true;

  double get labelWidth => 300.0;

  String get createText => currObjType == ObjectType.game ? "Создать игру" : "Создать задание";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Конструктор",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: labelWidth,
                  child: OptionSwitcher(
                      options: ObjectType.values,
                      onTap: (o) => setState(() => currObjType = o),
                      initialOption: currObjType,
                      stringMapper: (o) =>
                          o == ObjectType.game ? "Игры" : "Задания"),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                Container(
                  alignment: Alignment.center,
                  width: labelWidth,
                  child: OptionSwitcher(
                      options: Source.values,
                      onTap: (o) => setState(() => currSource = o),
                      initialOption: currSource,
                      stringMapper: (o) => o == Source.owned ? "Свои" : "Каталог"),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                SizedBox(
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
                          onPressed: () => setState(() => descending = !descending),
                          iconData: descending
                              ? Icons.arrow_downward
                              : Icons.arrow_upward)
                    ],
                  ),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                SizedBox(
                  height: 300,
                  child: currObjType == ObjectType.game
                    ? buildGameList(onTapOnGame: (g) {}, source: currSource)
                    : buildTaskList(onTapOnTask: (t) {}, source: currSource),
                )
              ],
            ),
            CustomButton(text: createText, onPressed: () => Navigator.pushNamed(context, GameCreateScreen.routeName))
          ],
        ));
  }
}
