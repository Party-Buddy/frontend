import 'package:flutter/material.dart';
import 'package:party_games_app/core/widgets/multiline_input_label.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class PollTaskTextWidget extends StatefulWidget {
  const PollTaskTextWidget({super.key, required this.pollTask});

  final PollTask pollTask;

  @override
  State<PollTaskTextWidget> createState() => _PollTaskTextWidgetState();
}

class _PollTaskTextWidgetState extends State<PollTaskTextWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiLineInputLabel(
      labelText: "Введите ответ",
      onSubmitted: (s) {});
  }
}
