import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/dropdown_button.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

class ConstructorScreen extends StatefulWidget {
  const ConstructorScreen({super.key});

  static const routeName = "/Constructor";

  @override
  State<ConstructorScreen> createState() => _ConstructorScreenState();
}

enum ObjectType { task, game }

enum SortType { date, type }

class _ConstructorScreenState extends State<ConstructorScreen> {
  ObjectType currentObj = ObjectType.game;
  GameType currentType = GameType.owned;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Конструктор",
        content: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 300,
              child: OptionSwitcher(
                  options: ObjectType.values,
                  onTap: (o) {},
                  initialOption: currentObj,
                  stringMapper: (o) =>
                      o == ObjectType.game ? "Игры" : "Задания"),
            ),
            const SizedBox(
              height: kPadding * 2,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 250,
                  child: OptionSwitcher(
                      options: GameType.values,
                      minOptionWidth: 90,
                      onTap: (o) {},
                      initialOption: currentType,
                      stringMapper: (o) =>
                          o == GameType.owned ? "Свои" : "Каталог"),
                ),
                const SizedBox(
                  width: kPadding,
                ),
                CustomDropDownButton(
                    initialItem: SortType.date,
                    items: SortType.values,
                    stringMapper: (t) => switch (t) {
                      SortType.date => "По дате",
                      SortType.type => "По типу"
                    },
                    onChanged: (s) {})
              ],
            )
          ],
        ));
  }
}
