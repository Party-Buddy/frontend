import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/image_network.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/checked_text_task_widget.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/choice_task_widget.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/poll_task_image_widget.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/poll_task_text_widget.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskScreenArguments {
  final TaskInfo taskInfo;
  final CurrentTask currentTask;
  final SessionEngine sessionEngine;
  final int tasksCount;

  TaskScreenArguments(
      {required this.taskInfo,
      required this.currentTask,
      required this.tasksCount,
      required this.sessionEngine});
}

class TaskScreen extends StatelessWidget {
  const TaskScreen(
      {super.key,
      required this.taskInfo,
      required this.currentTask,
      required this.tasksCount,
      required this.sessionEngine});

  static const routeName = "/Task";

  final TaskInfo taskInfo;
  final CurrentTask currentTask;
  final SessionEngine sessionEngine;
  final int tasksCount;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Задание",
        showBackButton: false,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  buildTaskHeader(
                      taskInfo: taskInfo,
                      index: currentTask.index,
                      total: tasksCount),
                  Container(
                    padding: kPaddingAll,
                    child: Text(
                      taskInfo.description,
                      style: defaultTextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                  if (taskInfo.photoUrl != null)
                    Container(
                      padding: const EdgeInsets.only(bottom: kPadding),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: kBorderRadius,
                        child: ImageNetwork(
                          url: taskInfo.photoUrl!,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                  buildTaskContent(),
                ],
              ),
            ),
            Column(
              children: [
                CustomButton(
                    text: "Покинуть игру",
                    onPressed: () => showConfirmationDialog(context,
                        text: "Вы точно хотите выйти?",
                        onConfirmed: () => onExit(context))),
                const SizedBox(
                  height: kPadding * 2,
                ),
                LinearTimer(
                  duration: Duration(seconds: taskInfo.duration),
                  color: kPrimaryColor,
                  backgroundColor: kAppBarColor,
                ),
              ],
            )
          ],
        )
    );
  }

  void onExit(BuildContext context) {
    sessionEngine.leaveSession();
    Navigator.pushNamed(context, MainMenuScreen.routeName);
  }

  static Row buildTaskHeader(
      {required TaskInfo taskInfo, required int index, required int total}) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
            flex: 3,
            child: Center(
              child: Wrap(
                children: [
                  BorderWrapper(
                    borderColor: kPrimaryColor,
                    child: Text(
                      taskInfo.name,
                      style: defaultTextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )),
        Expanded(
          child: Center(
            child: Wrap(
              children: [
                BorderWrapper(
                    fillColor: kAppBarColor.withOpacity(.5),
                    child: Text("${index + 1}/$total",
                        style: defaultTextStyle(
                            fontSize: 16, color: lighten(kPrimaryColor, .15)))),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildTaskContent() {
    switch (taskInfo.type) {
      case TaskType.choice:
        return ChoiceTaskWidget(
            taskInfo: taskInfo,
            currentTask: currentTask,
            sessionEngine: sessionEngine);
      case TaskType.poll:
        {
          switch (taskInfo.pollAnswerType!) {
            case PollTaskAnswerType.text:
              return PollTaskTextWidget(
                  taskInfo: taskInfo,
                  currentTask: currentTask,
                  sessionEngine: sessionEngine);
            case PollTaskAnswerType.image:
              return PollTaskImageWidget(
                  taskInfo: taskInfo,
                  currentTask: currentTask,
                  sessionEngine: sessionEngine);
          }
        }
      case TaskType.checkedText:
        return CheckedTextTaskWidget(
            taskInfo: taskInfo,
            currentTask: currentTask,
            sessionEngine: sessionEngine);
    }
  }
}
