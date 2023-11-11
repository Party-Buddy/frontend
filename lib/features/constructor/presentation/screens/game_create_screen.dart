import 'package:flutter/material.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Создать игру",
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kPadding,
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
              buildTaskList()
            ],
          ),
        ));
  }

  void onReorder(int oldIdx, int newIdx) {
    if (oldIdx < newIdx) {
      newIdx--;
    }

    Task t = selectedTasks.removeAt(oldIdx);
    selectedTasks.insert(newIdx, t);
  }

  Widget buildTaskList() {
    return Container(
      padding: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
      decoration: BoxDecoration(
          color: kAppBarColor.withOpacity(.5), borderRadius: kBorderRadius),
      child: Column(
        children: [
          Column(
            children: selectedTasks
                .map((task) => Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kPadding / 2),
                      child: Row(
                        children: [
                          TaskHeader(task: task, onTap: () {}),
                          const SizedBox(width: kPadding,),
                          CustomIconButton(onPressed: () => setState(() {
                            selectedTasks.remove(task);
                          }), iconData: Icons.close)
                        ],
                      ),
                    ))
                .toList(),
          ),
          // SizedBox(
          //   height: 400,
          //   child: ReorderableListView(onReorder: onReorder, children: [
          //     for (Task task in selectedTasks)
          //         ListTile(key: ValueKey(task.id), title: TaskHeader(task: task, onTap: () {},), )
          //   ]),
          // ),
          const SizedBox(
            height: kPadding,
          ),
          CustomButton(
              text: "Добавить задание",
              onPressed: () => showWidget(context,
                  content: TaskList(
                      onTapOnTask: (t) {
                        if (selectedTasks.contains(t)) {
                          showMessage(context, "Задание '${t.name}' уже добавлено.");
                          return;
                        }
                        setState(() {
                            selectedTasks.add(t);
                          });
                      })))
        ],
      ),
    );
  }
}
