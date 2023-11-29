import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/custom_check_box.dart';
import 'package:party_games_app/core/widgets/multiline_input_label.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/ready_confirmation_label.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';

class CheckedTextTaskWidget extends StatefulWidget {
  const CheckedTextTaskWidget({super.key, required this.checkedTask});

  final CheckedTextTask checkedTask;

  @override
  State<CheckedTextTaskWidget> createState() => _CheckedTextTaskWidgetState();
}

class _CheckedTextTaskWidgetState extends State<CheckedTextTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiLineInputLabel(labelText: "Введите ответ", onSubmitted: (s) {}),
        const SizedBox(
          height: kPadding,
        ),
        ReadyConfirmationLabel(enabledNotifier: ValueNotifier(false),)
      ],
    );
  }
}
