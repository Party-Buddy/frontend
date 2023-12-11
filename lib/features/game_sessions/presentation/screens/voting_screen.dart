import 'package:flutter/cupertino.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/image_widget.dart';
import 'package:party_games_app/core/widgets/switch_border_wrapper.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/poll_info.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class VotingScreenArguments {
  final SessionEngine sessionEngine;
  final PollInfo pollInfo;
  final TaskInfo taskInfo;
  final String gameName;
  final int tasksCount;

  VotingScreenArguments(
      {required this.sessionEngine,
      required this.pollInfo,
      required this.taskInfo,
      required this.gameName,
      required this.tasksCount});
}

class VotingScreen extends StatelessWidget {
  VotingScreen(
      {super.key,
      required this.sessionEngine,
      required this.pollInfo,
      required this.taskInfo,
      required this.gameName,
      required this.tasksCount});

  static const routeName = "/Voting";

  final SessionEngine sessionEngine;
  final PollInfo pollInfo;
  final TaskInfo taskInfo;
  final String gameName;
  final int tasksCount;
  final ValueNotifier<int?> choiceNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Голосование",
        showBackButton: false,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TaskScreen.buildTaskHeader(
                  taskInfo: taskInfo, index: pollInfo.index, total: tasksCount),
            ),
            const SizedBox(height: kPadding * 2,),
            Text("Выберите понравившийся вариант", style: defaultTextStyle(fontSize: 20),),
            const SizedBox(height: kPadding * 2,),
            Expanded(
              flex: 16,
              child: SingleChildScrollView(
                child: ValueListenableBuilder(
                  valueListenable: choiceNotifier,
                  builder: (context, choiceIdx, child) => Wrap(
                    spacing: kPadding * 1.5,
                    runSpacing: kPadding * 1.5,
                    children: [
                      for (int i = 0; i < pollInfo.options.length; i++)
                        buildPollOption(i, choiceIdx)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(),
                  LinearTimer(
                    duration:
                        DateTime.fromMillisecondsSinceEpoch(pollInfo.deadline)
                            .difference(DateTime.now()),
                    color: kPrimaryColor,
                    backgroundColor: kAppBarColor,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void onExit(BuildContext context) {
    sessionEngine.leaveSession();
    Navigator.pushNamed(context, MainMenuScreen.routeName);
  }

  Widget buildPollOption(int idx, int? choiceIdx) {
    Widget child;
    if (taskInfo.pollAnswerType == PollTaskAnswerType.text) {
      child = Text(
        pollInfo.options[idx],
        style: defaultTextStyle(),
      );
    } else {
      child = ImageWidget(url: pollInfo.options[idx], height: 120, width: 120);
    }
    return Padding(
        padding: const EdgeInsets.all(kPadding / 2),
        child: SwitchBorderWrapper(
            key: Key("$idx ${idx == choiceIdx}"),
            onChanged: (enabled) {
              if (enabled) {
                choiceNotifier.value = idx;
              } else {
                choiceNotifier.value = null;
              }
            },
            initialEnabled: idx == choiceIdx,
            child: child));
  }
}
