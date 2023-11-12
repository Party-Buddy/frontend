import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/core/widgets/image_uploader.dart';
import 'package:party_games_app/core/widgets/multiline_input_label.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
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
  List<Task> selectedTasks = [];
  File? image;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Создать игру",
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: kPadding,
              ),
              ImageUploader(onUpdate: (image) => this.image = image),
              const SizedBox(
                height: kPadding * 2,
              ),
              SingleLineInputLabel(
                  labelText: "Название игры",
                  onSubmitted: (s) => SubmitResult.empty),
              const SizedBox(
                height: kPadding * 2,
              ),
              MultiLineInputLabel(
                  labelText: "Описание игры", onSubmitted: (s) {}),
              const SizedBox(
                height: kPadding * 2,
              ),
              buildTaskList(context)
            ],
          ),
        ));
  }

  void onReorder(int oldIdx, int newIdx) {
    if (oldIdx < newIdx) {
      newIdx--;
    }

    setState(() {
      Task t = selectedTasks.removeAt(oldIdx);
      selectedTasks.insert(newIdx, t);
    });
  }

  Widget buildTaskList(BuildContext context) {
    return Container(
      padding: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: kAppBarColor.withOpacity(.5), borderRadius: kBorderRadius),
      child: SizedBox(
        height: 70 + selectedTasks.length * 115,
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
                          if (selectedTasks.contains(t)) {
                            showMessage(
                                context, "Задание '${t.name}' уже добавлено.");
                            return;
                          }
                          setState(() {
                            selectedTasks.add(t);
                          });
                        }))),
              ),
              children: [
                for (Task task in selectedTasks)
                  ListTile(
                    key: ValueKey(task.id),
                    contentPadding: const EdgeInsets.all(0),
                    iconColor: Colors.transparent,
                    title: ReorderableDelayedDragStartListener(
                        index: selectedTasks.indexOf(task),
                        child: TaskHeader(
                          enableShadow: false,
                          task: task,
                          onTap: () {
                            print(task.name);
                          },
                        )),
                    trailing: CustomIconButton(
                        onPressed: () => setState(() {
                              selectedTasks.remove(task);
                            }),
                        iconData: Icons.close),
                  ),
              ]),
        ),
      ),
    );
  }
}
