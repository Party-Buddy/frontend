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
import 'package:party_games_app/features/games/domain/usecases/params/games_sort_params.dart';
import 'package:party_games_app/features/games/presentation/screens/game_info_screen.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_list.dart';
import 'package:party_games_app/features/tasks/domain/usecases/params/tasks_sort_params.dart';
import 'package:party_games_app/features/tasks/presentation/screens/task_info_screen.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_list.dart';

enum ObjectType { task, game }

class ConstructorScreen extends StatelessWidget {
  ConstructorScreen({super.key});

  static const routeName = "/Constructor";
  static final updateNotifier = ValueNotifier(0);

  final currObjNotifier = ValueNotifier(ObjectType.game);
  final currSourceNotifier = ValueNotifier(Source.owned);
  final currSortType = ValueNotifier(SortType.date);
  final isAscendingSort = ValueNotifier(false);
  final tasksSortParams =
      ValueNotifier(TasksSortParams(updateDateAscending: false));
  final gamesSortParams =
      ValueNotifier(GamesSortParams(updateDateAscending: false));

  double get labelWidth => 300.0;

  void applySort() {
    if (currObjNotifier.value == ObjectType.task) {
      TasksSortParams params;
      switch (currSortType.value) {
        case SortType.name:
          params = TasksSortParams(nameAscending: isAscendingSort.value);
        case SortType.date:
          params = TasksSortParams(updateDateAscending: isAscendingSort.value);
      }
      tasksSortParams.value = params;
    } else {
      GamesSortParams params;
      switch (currSortType.value) {
        case SortType.name:
          params = GamesSortParams(nameAscending: isAscendingSort.value);
        case SortType.date:
          params = GamesSortParams(updateDateAscending: isAscendingSort.value);
      }
      gamesSortParams.value = params;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: updateNotifier,
      builder: (context, value, child) => BaseScreen(
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
                      margin:
                          const EdgeInsets.symmetric(vertical: kPadding / 2),
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
                      margin:
                          const EdgeInsets.symmetric(vertical: kPadding / 2),
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
            ValueListenableBuilder(
              valueListenable: currSourceNotifier,
              builder: (context, value, child) => Visibility(
                visible: currSourceNotifier.value == Source.owned,
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
                          height: 45,
                          child: CustomDropDownButton(
                              width: 120,
                              initialItem: SortType.date,
                              items: SortType.values,
                              stringMapper: (t) => switch (t) {
                                    SortType.name => "По названию",
                                    SortType.date => "По дате"
                                  },
                              onChanged: (sortType) {
                                currSortType.value = sortType;
                                applySort();
                              }),
                        ),
                        const SizedBox(
                          width: kPadding,
                        ),
                        ValueListenableBuilder(
                          valueListenable: isAscendingSort,
                          builder: (context, value, child) => CustomIconButton(
                              onPressed: () {
                                isAscendingSort.value = !isAscendingSort.value;
                                applySort();
                              },
                              iconData: !isAscendingSort.value
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: currSourceNotifier,
              builder: (context, value, child) => ValueListenableBuilder(
                valueListenable: currObjNotifier,
                builder: (context, value, child) => Expanded(
                  flex: currSourceNotifier.value == Source.owned ? 7 : 8,
                  child: currObjNotifier.value == ObjectType.game
                      ? ValueListenableBuilder(
                          valueListenable: gamesSortParams,
                          builder: (context, params, child) =>
                              buildGameList(context, onTapOnGame: (game) {
                            Navigator.pushNamed(
                                context, GameInfoScreen.routeName,
                                arguments: GameInfoScreenArguments(game: game));
                          }, source: currSourceNotifier.value, params: params),
                        )
                      : ValueListenableBuilder(
                          valueListenable: tasksSortParams,
                          builder: (context, params, child) =>
                              buildTaskList(context, onTapOnTask: (task) {
                            Navigator.pushNamed(
                                context, TaskInfoScreen.routeName,
                                arguments: TaskInfoScreenArguments(task: task));
                          }, source: currSourceNotifier.value, params: params),
                        ),
                ),
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
                        onPressed: () => value == ObjectType.game
                            ? Navigator.pushNamed(
                                context, GameCreateScreen.routeName)
                            : Navigator.pushNamed(
                                context, TaskCreateScreen.routeName)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
