import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
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

  TaskScreenArguments(
      {required this.taskInfo,
      required this.currentTask,
      required this.sessionEngine});
}

class TaskScreen extends StatelessWidget {
  const TaskScreen(
      {super.key,
      required this.taskInfo,
      required this.currentTask,
      required this.sessionEngine});

  static const routeName = "/Task";

  final TaskInfo taskInfo;
  final CurrentTask currentTask;
  final SessionEngine sessionEngine;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Задание",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: BorderWrapper(
                    border: Border.all(width: 1, color: kPrimaryColor),
                    child: Text(
                      taskInfo.name,
                      style: defaultTextStyle(fontSize: 20),
                    ),
                  ),
                ),
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
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: kBorderRadius,
                      child: Image.network(taskInfo.photoUrl!),
                    ),
                  ),
                buildTaskContent(),
              ],
            ),
            Column(
              children: [
                CustomButton(
                    text: "Покинуть игру",
                    onPressed: () => showConfirmationDialog(context,
                        text: "Вы точно хотите выйти?",
                        onConfirmed: () => Navigator.pushNamed(
                            context, MainMenuScreen.routeName))),
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
        ));
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
