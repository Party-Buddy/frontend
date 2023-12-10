import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/multiline_input_label.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/ready_confirmation_label.dart';

class PollTaskTextWidget extends StatefulWidget {
  const PollTaskTextWidget(
      {super.key,
      required this.taskInfo,
      required this.currentTask,
      required this.sessionEngine});

  final TaskInfo taskInfo;
  final CurrentTask currentTask;
  final SessionEngine sessionEngine;

  @override
  State<PollTaskTextWidget> createState() => _PollTaskTextWidgetState();
}

class _PollTaskTextWidgetState extends State<PollTaskTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleLineInputLabel(
            labelText: "Введите ответ",
            onSubmitted: (s) async {
              return SubmitResult.empty;
            }),
        const SizedBox(
          height: kPadding,
        ),
        ReadyConfirmationLabel(
          enabledNotifier: ValueNotifier(false),
        )
      ],
    );
  }
}
