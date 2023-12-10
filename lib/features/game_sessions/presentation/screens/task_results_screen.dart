import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/image_network.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_results.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

TaskResults checkedTextTaskResultsMock() =>
    TaskResults(
        index: 3,
        deadline: DateTime
            .now()
            .add(const Duration(seconds: 15))
            .millisecondsSinceEpoch,
        scoreboard: [
          PlayerResult(playerId: 0, score: 2, totalScore: 4),
          PlayerResult(playerId: 1, score: 3, totalScore: 3),
          PlayerResult(playerId: 2, score: 1, totalScore: 2),
          PlayerResult(playerId: 3, score: 4, totalScore: 6),
        ],
        answers: [
          TaskAnswer(value: "Помидор", score: 3, correct: false),
          TaskAnswer(value: "Огурец", score: 1, correct: false),
          TaskAnswer(value: "Банан", score: 0, correct: false),
          TaskAnswer(value: "Огород", score: 0, correct: true),
        ]);

TaskResults photoTaskResultsMock() =>
    TaskResults(
        index: 3,
        deadline: DateTime
            .now()
            .add(const Duration(seconds: 15))
            .millisecondsSinceEpoch,
        scoreboard: [
          PlayerResult(playerId: 0, score: 2, totalScore: 4),
          PlayerResult(playerId: 1, score: 3, totalScore: 3),
          PlayerResult(playerId: 2, score: 1, totalScore: 2),
          PlayerResult(playerId: 3, score: 4, totalScore: 6),
        ],
        answers: [
          TaskAnswer(
              value:
              "https://calorizator.ru/sites/default/files/imagecache/product_512/product/cucumber-1.jpg",
              score: 3,
              correct: false),
          TaskAnswer(
              value:
              "https://m.dom-eda.com/uploads/images/catalog/item/c6ebcf64ba/e87b941b85_500.jpg",
              score: 1,
              correct: false),
          TaskAnswer(
              value:
              "https://main-cdn.sbermegamarket.ru/big2/hlr-system/166/623/387/391/411/3/100039740892b0.jpg",
              score: 2,
              correct: false),
          TaskAnswer(
              value:
              "https://avatars.dzeninfra.ru/get-zen_doc/1780598/pub_5cdd36137ff3a600b290bf7f_5cddbb19dee36d00b47e4c0c/scale_1200",
              score: 0,
              correct: true),
        ]);

class TaskResultsScreenArguments {
  final TaskResults taskResults;
  final TaskInfo taskInfo;
  final String gameName;
  final List<GamePlayer> players;
  final int tasksCount;

  TaskResultsScreenArguments({required this.taskResults,
    required this.taskInfo,
    required this.gameName,
    required this.players,
    required this.tasksCount});
}

class TaskResultsScreen extends StatelessWidget {
  TaskResultsScreen({super.key,
    required this.taskResults,
    required this.taskInfo,
    required this.gameName,
    required this.players,
    required this.tasksCount}) {
    taskResults.answers.sort((a1, a2) => -a1.score.compareTo(a2.score));

    winnerScoreThreshold = taskResults.answers
        .map((e) => e.score)
        .sorted((a, b) => a.compareTo(b))
        .reversed
        .take(3)
        .min;
  }

  static const routeName = "/TaskResults";

  final TaskResults taskResults;
  final TaskInfo taskInfo;
  final String gameName;
  final List<GamePlayer> players;
  final int tasksCount;
  late final int winnerScoreThreshold;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Итоги задания",
        showBackButton: false,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TaskScreen.buildTaskHeader(
                    taskInfo: taskInfo,
                    index: taskResults.index,
                    total: tasksCount),
                const SizedBox(
                  height: kPadding,
                ),
                SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .6,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.all(kPadding * 2),
                        child: buildContent(context))
                ),
                Visibility(
                  visible: taskInfo.description.isNotEmpty,
                  child: CustomButton(
                      text: "Описание задания",
                      onPressed: () =>
                          showMessage(context, taskInfo.description)),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                CustomButton(
                    text: "Покинуть игру",
                    onPressed: () =>
                        showConfirmationDialog(context,
                            text: "Вы точно хотите выйти?",
                            onConfirmed: () =>
                                Navigator.pushNamed(
                                    context, MainMenuScreen.routeName))),
                const SizedBox(
                  height: kPadding * 2,
                ),
              ],
            ),
            Column(
              children: [
                LinearTimer(
                  duration:
                  DateTime.fromMillisecondsSinceEpoch(taskResults.deadline)
                      .difference(DateTime.now()),
                  color: kPrimaryColor,
                  backgroundColor: kAppBarColor,
                ),
              ],
            )
          ],
        ));
  }

  Widget buildContent(BuildContext context) {
    switch (taskInfo.type) {
      case TaskType.checkedText:
        return Container();
      case TaskType.choice:
        return Container();
      case TaskType.poll:
        {
          var answerType = taskInfo.pollAnswerType!;
          switch (answerType) {
            case PollTaskAnswerType.text:
              return Container();
            case PollTaskAnswerType.image:
              return buildPhotoAnswers(context);
          }
        }
    }
  }

  Widget buildPhotoAnswers(BuildContext context) {
    return Wrap(
      spacing: kPadding,
      runSpacing: kPadding,
      children: taskResults.answers
          .map((answer) =>
          GestureDetector(
            onTap: () {
              showWidget(context, content: ClipRRect(
                  borderRadius: kBorderRadius,
                  child: ImageNetwork(
                    url: answer.value,
                    width: 300,
                    height: 300,
                  )));
            },
            child: BorderWrapper(
                shadow: answer.score >= winnerScoreThreshold,
                blurRadius: 8,
                shadowColor: kPrimaryColor,
                child: ImageNetwork(
                  url: answer.value,
                  width: 120,
                  height: 120,
                )),
          ))
          .toList(),
    );
  }
}
