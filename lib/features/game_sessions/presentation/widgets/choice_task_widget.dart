import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/switch_border_wrapper.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/ready_confirmation_label.dart';

class ChoiceTaskWidget extends StatefulWidget {
  const ChoiceTaskWidget(
      {super.key,
      required this.taskInfo,
      required this.currentTask,
      required this.sessionEngine});

  final TaskInfo taskInfo;
  final CurrentTask currentTask;
  final SessionEngine sessionEngine;

  @override
  State<ChoiceTaskWidget> createState() => _ChoiceTaskWidgetState();
}

class _ChoiceTaskWidgetState extends State<ChoiceTaskWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
            children: widget.currentTask.options!
                .map((op) => buildOptionWidget(op))
                .toList()),
        Visibility(
          visible: selectedOption != null,
            child:
                ReadyConfirmationLabel(enabledNotifier: ValueNotifier(false)))
      ],
    );
  }

  Widget buildOptionWidget(String option) {
    Widget child = Text(
      option,
      style: defaultTextStyle(),
    );
    return Padding(
      padding: const EdgeInsets.all(kPadding / 2),
      child: SwitchBorderWrapper(
          key: Key("${selectedOption==option}"),
          onChanged: (enabled) {
            if (enabled) {
              setState(() {
                selectedOption = option;
              });
            } else {
              setState(() {
                selectedOption = null;
              });
            }
          },
          initialEnabled: selectedOption == option,
          child: child),
    );
  }
}
