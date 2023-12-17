import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/core/widgets/image_uploader.dart';
import 'package:party_games_app/core/widgets/multiline_input_label.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/features/constructor/presentation/screens/constructor_screen.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/usecases/params/game_params.dart';
import 'package:party_games_app/features/games/domain/usecases/save_game.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_header.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_list.dart';

class GameCreateScreen extends StatefulWidget {
  const GameCreateScreen({super.key});

  static const String routeName = "/GameCreate";

  @override
  State<GameCreateScreen> createState() => _GameCreateScreenState();
}

class _GameCreateScreenState extends State<GameCreateScreen> {
  List<Task> tasks = [];
  File? image;
  String name = "";
  String description = "";

  final SaveGameUseCase _saveGameUseCase = GetIt.instance<SaveGameUseCase>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Создать игру",
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: kPadding,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: kPadding),
                child: ImageUploader(onUpdate: (image) => this.image = image),
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              SingleLineInputLabel(
                  labelText: "Название игры",
                  onSubmitted: (s) async {
                    setState(() {
                      name = s;
                    });
                    return SubmitResult.empty;
                  }),
              const SizedBox(
                height: kPadding * 2,
              ),
              MultiLineInputLabel(
                  labelText: "Описание игры",
                  onSubmitted: (s) {
                    setState(() {
                      description = s;
                    });
                  }),
              const SizedBox(
                height: kPadding * 2,
              ),
              buildTaskList(context),
              Visibility(
                visible: name.isNotEmpty && description.isNotEmpty && tasks.isNotEmpty,
                  child: Column(
                children: [
                  const SizedBox(
                    height: kPadding * 2,
                  ),
                  CustomButton(text: "Создать игру", onPressed: () async {
                    Game game = OwnedGame(name: name, description: description, tasks: tasks, imageUri: image?.path);
                    await _saveGameUseCase.call(params: GameParams(game: game));
                    await Future.microtask(() => Navigator.of(context).pop());
                    ConstructorScreen.updateNotifier.value = ConstructorScreen.updateNotifier.value + 1;
                  }),
                  const SizedBox(
                    height: kPadding * 2,
                  ),
                ],
              ))
            ],
          ),
        ));
  }

  void onReorder(int oldIdx, int newIdx) {
    if (oldIdx < newIdx) {
      newIdx--;
    }

    setState(() {
      Task t = tasks.removeAt(oldIdx);
      tasks.insert(newIdx, t);
    });
  }

  Widget buildTaskList(BuildContext context) {
    return Container(
      padding: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: kAppBarColor.withOpacity(.5), borderRadius: kBorderRadius),
      child: SizedBox(
        height: 70 + tasks.length * 115,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: ReorderableListView(
              onReorder: onReorder,
              buildDefaultDragHandles: false,
              footer: Container(
                padding: kPaddingAll,
                child: CustomButton(
                    text: "Добавить задание",
                    fontSize: 17,
                    onPressed: () =>
                        showWidget(context, content: TaskList(onTapOnTask: (t) {
                          if (tasks.contains(t)) {
                            showMessage(
                                context, "Задание '${t.name}' уже добавлено.");
                            return;
                          }
                          setState(() {
                            tasks.add(t);
                          });
                        }))),
              ),
              children: [
                for (Task task in tasks)
                  ListTile(
                    key: ValueKey(task.hashId),
                    contentPadding: const EdgeInsets.all(0),
                    iconColor: Colors.transparent,
                    title: ReorderableDelayedDragStartListener(
                        index: tasks.indexOf(task),
                        child: TaskHeader(
                          enableShadow: false,
                          imgSize: 80,
                          task: task,
                          onTap: () {
                          },
                        )),
                    trailing: CustomIconButton(
                        onPressed: () => setState(() {
                              tasks.remove(task);
                            }),
                        iconData: Icons.close),
                  ),
              ]),
        ),
      ),
    );
  }
}
