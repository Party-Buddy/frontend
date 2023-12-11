import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/image_widget.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_results.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

TaskResults choiceTaskResultsMock() => TaskResults(
        index: 3,
        deadline: DateTime.now()
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

TaskResults checkedTextTaskResultsMock() => TaskResults(
        index: 3,
        deadline: DateTime.now()
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

TaskResults textPollTaskResultsMock() => TaskResults(
        index: 3,
        deadline: DateTime.now()
            .add(const Duration(seconds: 15))
            .millisecondsSinceEpoch,
        scoreboard: [
          PlayerResult(playerId: 0, score: 2, totalScore: 4),
          PlayerResult(playerId: 1, score: 3, totalScore: 3),
          PlayerResult(playerId: 2, score: 1, totalScore: 2),
          PlayerResult(playerId: 3, score: 4, totalScore: 6),
        ],
        answers: [
          TaskAnswer(value: "Помидор", score: 4, correct: false),
          TaskAnswer(value: "Огурец", score: 2, correct: false),
          TaskAnswer(value: "Банан", score: 2, correct: false),
          TaskAnswer(value: "Огород", score: 0, correct: true),
        ]);

TaskResults imagePollTaskResultsMock() => TaskResults(
        index: 3,
        deadline: DateTime.now()
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
  final SessionEngine sessionEngine;
  final TaskResults taskResults;
  final TaskInfo taskInfo;
  final String gameName;
  final List<GamePlayer> players;
  final int tasksCount;

  TaskResultsScreenArguments(
      {required this.sessionEngine,
      required this.taskResults,
      required this.taskInfo,
      required this.gameName,
      required this.players,
      required this.tasksCount});
}

class TaskResultsScreen extends StatelessWidget {
  TaskResultsScreen(
      {super.key,
      required this.sessionEngine,
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

  final SessionEngine sessionEngine;
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
          children: [
            Expanded(
              child: TaskScreen.buildTaskHeader(
                  taskInfo: taskInfo,
                  index: taskResults.index,
                  total: tasksCount),
            ),
            Expanded(
              flex: 11,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(kPadding * 2),
                  child: buildContent(context)),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
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
                      onPressed: () => showConfirmationDialog(context,
                          text: "Вы точно хотите выйти?",
                          onConfirmed: () => onExit(context))),
                  const SizedBox(
                    height: kPadding * 2,
                  ),
                  LinearTimer(
                    duration: DateTime.fromMillisecondsSinceEpoch(
                            taskResults.deadline)
                        .difference(DateTime.now()),
                    color: kPrimaryColor,
                    backgroundColor: kAppBarColor,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void onExit(BuildContext context) {
    sessionEngine.leaveSession();
    Navigator.pushNamed(context, MainMenuScreen.routeName);
  }

  Widget buildContent(BuildContext context) {
    switch (taskInfo.type) {
      case TaskType.checkedText:
        return buildCheckedTextAnswers(context);
      case TaskType.choice:
        return buildChoiceAnswers(context);
      case TaskType.poll:
        {
          var answerType = taskInfo.pollAnswerType!;
          switch (answerType) {
            case PollTaskAnswerType.text:
              return buildTextPollAnswers(context);
            case PollTaskAnswerType.image:
              return buildImagePollAnswers(context);
          }
        }
    }
  }

  double get fontSize => 20;

  Widget buildChoiceAnswers(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Вариант",
            style: defaultTextStyle(fontSize: fontSize),
          ),
          Text(
            "Количество ответов",
            style: defaultTextStyle(fontSize: fontSize),
          )
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: kPadding),
        height: 1.5,
        width: double.infinity,
        color: kPrimaryColor,
      ),
      Column(
        children: taskResults.answers
            .map((answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BorderWrapper(
                            shadow: answer.correct != null && answer.correct!,
                            child: Text(
                              answer.value,
                              style: defaultTextStyle(fontSize: fontSize),
                            ),
                          ),
                          BorderWrapper(
                            child: Text(
                              answer.score.toString(),
                              style: defaultTextStyle(fontSize: fontSize),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))
            .toList(),
      )
    ]);
  }

  Widget buildCheckedTextAnswers(BuildContext context) {
    var correctAnswer = taskResults.answers
        .where((answer) => answer.correct != null && answer.correct!)
        .firstOrNull;
    if (correctAnswer == null) {
      return buildTextPollAnswers(context);
    }
    var incorrectAnswers = taskResults.answers
        .where((answer) =>
            answer.correct == null ||
            (answer.correct != null && !answer.correct!))
        .toList();
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Правильный ответ:",
                style: defaultTextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: kPadding * 1.5,
              ),
              BorderWrapper(
                shadow: true,
                child: Text(
                  correctAnswer.value,
                  style: defaultTextStyle(fontSize: fontSize),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: kPadding * 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ответило правильно:",
              style: defaultTextStyle(fontSize: fontSize),
            ),
            Text(
              correctAnswer.score.toString(),
              style: defaultTextStyle(fontSize: fontSize, color: kPrimaryColor),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: kPadding * 2),
          width: double.infinity,
          height: 2,
          color: kPrimaryColor,
        ),
        if (incorrectAnswers.isNotEmpty)
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Остальные ответы:",
              style: defaultTextStyle(fontSize: fontSize),
            ),
          ),
        if (incorrectAnswers.isNotEmpty)
          const SizedBox(
            height: kPadding * 2,
          ),
        if (incorrectAnswers.isNotEmpty)
          Wrap(
            spacing: kPadding,
            runSpacing: kPadding,
            children: incorrectAnswers
                .map((e) => BorderWrapper(
                      child: Text(
                        e.value,
                        style: defaultTextStyle(),
                      ),
                    ))
                .toList(),
          )
      ],
    );
  }

  Widget buildTextPollAnswers(BuildContext context) {
    return Wrap(
      spacing: kPadding * 1.5,
      runSpacing: kPadding * 1.5,
      children: taskResults.answers
          .map((answer) => BorderWrapper(
              shadow: answer.score >= winnerScoreThreshold,
              blurRadius: 8,
              shadowColor: kPrimaryColor,
              child: Text(
                answer.value,
                style: defaultTextStyle(),
              )))
          .toList(),
    );
  }

  Widget buildImagePollAnswers(BuildContext context) {
    return Wrap(
      spacing: kPadding * 1.5,
      runSpacing: kPadding * 1.5,
      children: taskResults.answers
          .map((answer) => GestureDetector(
                onTap: () {
                  showWidget(context,
                      content: ClipRRect(
                          borderRadius: kBorderRadius,
                          child: ImageWidget(
                            url: answer.value,
                            width: 300,
                            height: 300,
                          )));
                },
                child: BorderWrapper(
                    shadow: answer.score >= winnerScoreThreshold,
                    blurRadius: 8,
                    shadowColor: kPrimaryColor,
                    child: ImageWidget(
                      url: answer.value,
                      width: 120,
                      height: 120,
                    )),
              ))
          .toList(),
    );
  }
}
