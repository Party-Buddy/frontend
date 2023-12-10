import 'package:flutter/cupertino.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/image_network.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskInfoScreenArguments {
  final Task task;

  const TaskInfoScreenArguments({required this.task});
}

class TaskInfoScreen extends StatelessWidget {
  const TaskInfoScreen({super.key, required this.task});

  static const routeName = "/TaskInfo";

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Описание задания",
        content: Column(
          children: [
            if (task.imageUri != null)
              Padding(
                padding:
                    const EdgeInsets.only(bottom: kPadding).add(kPaddingAll),
                child: BorderWrapper(
                    shadow: true,
                    child: ImageNetwork(
                      url: task.imageUri!,
                      width: 200,
                      height: 200,
                    )),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderWrapper(
                      child: Text(
                    "Название",
                    style: defaultTextStyle(),
                  )),
                  BorderWrapper(
                      borderColor: kPrimaryColor,
                      child: Text(
                        task.name,
                        style: defaultTextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: kPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BorderWrapper(
                    child: Text(
                  "Тип задания",
                  style: defaultTextStyle(),
                )),
                BorderWrapper(
                  borderColor: kPrimaryColor,
                  child: Text(
                    taskTypeInfo,
                    style: defaultTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BorderWrapper(
                    child: Text(
                      "Время выполнения",
                      style: defaultTextStyle(),
                    )),
                BorderWrapper(
                  borderColor: kPrimaryColor,
                  child: Text(
                    "${task.duration} секунд",
                    style: defaultTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kPadding,
            ),
            Container(
              margin: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
              width: double.infinity,
              height: 1.5,
              color: kPrimaryColor,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BorderWrapper(child: Text("Описание задания", style: defaultTextStyle(),)),
                  const SizedBox(
                    height: kPadding / 2,
                  ),
                  BorderWrapper(
                      child: Text(task.description, style: defaultTextStyle(),)),
                ],
              ),
            )
          ],
        ));
  }

  String get taskTypeInfo {
    switch (task.type) {
      case TaskType.checkedText:
        return "С проверкой текста";
      case TaskType.poll:
        return "С голосованием";
      case TaskType.choice:
        return "С выбором ответа";
    }
  }
}
