import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_screen.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  static const routeName = "testScreen";

  static const ChoiceTask choiceTaskExample = ChoiceTask(
      name: "Выберите элемент, который выделяется",
      description:
          "Здесь должно быть описание задания, но пока тут будет просто текст для теста, чтобы проверить, что все хорошо отображается.",
      duration: 30,
      options: {
        ChoiceTaskOption(alternative: "Огурец", correct: false),
        ChoiceTaskOption(alternative: "Помидор", correct: true),
        ChoiceTaskOption(alternative: "Баклажан", correct: false),
        ChoiceTaskOption(alternative: "Винегрет", correct: false),
      });

  static const PollTask pollTaskTextExample = PollTask(
      name: "Напишите стих про монады",
      description:
          "Задание потребует ваших креативных способностей, нужно сложить стихотворение, оду, которое бы возвысило ФП над всем земным.",
      duration: 30,
      pollAnswerType: PollTaskAnswerType.text,
      pollFixedDuration: 3,
      pollDynamicDuration: 4);

  static const PollTask pollTaskImageExample = PollTask(
      name: "Нарисуйте Луну",
      description:
          "Задача состоит в том, чтобы нарисовать Луну. Не путать с сыром.",
      imageUri: "https://c02.purpledshub.com/uploads/sites/41/2023/08/How-do-I-see-the-super-blue-moon.jpg",
      duration: 30,
      pollAnswerType: PollTaskAnswerType.image,
      pollFixedDuration: 3,
      pollDynamicDuration: 4);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Тест экранов",
        content: Column(
          children: [
            CustomButton(
                text: "Задание с выборами ответа",
                onPressed: () => pushScreen(
                    context, const TaskScreen(task: choiceTaskExample))),
            const SizedBox(
              height: kPadding,
            ),
            CustomButton(
                text: "Задание с текстом",
                onPressed: () => pushScreen(
                    context, const TaskScreen(task: pollTaskTextExample))),
            const SizedBox(
              height: kPadding,
            ),
            CustomButton(
                text: "Задание с картинкой",
                onPressed: () => pushScreen(
                    context, const TaskScreen(task: pollTaskImageExample))),
          ],
        ));
  }

  void pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
}
