import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key, required this.task, required this.onTap});

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SelectableBorderWrapper(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BorderWrapper(
                  fillColor: lighten(kAppBarColor, .1),
                  child: Text(
                    task.name,
                    style: const TextStyle(
                        fontFamily: kFontFamily,
                        fontSize: 18,
                        color: kFontColor),
                  ),
                ),
                const SizedBox(
                  height: kPadding / 2,
                ),
                BorderWrapper(
                  fillColor: lighten(kAppBarColor, .1),
                  child: Text(
                    switch (task.type) {
                      TaskType.checkedText => "С проверкой ответа",
                      TaskType.choice => "С выбором варианта",
                      TaskType.poll => "С голосованием"
                    },
                    style: TextStyle(
                        fontFamily: kFontFamily,
                        fontSize: 16,
                        color: kFontColor.withOpacity(.9)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: kPadding),
              child: Image.network(
                task.imageUri ?? "TO DO",
                height: 90,
                width: 90,
              ),
            ),
          ],
        ));
  }
}
