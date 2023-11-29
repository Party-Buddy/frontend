import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';
import 'package:party_games_app/core/widgets/switch_border_wrapper.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/ready_confirmation_label.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';

class ChoiceTaskWidget extends StatefulWidget {
  const ChoiceTaskWidget({super.key, required this.choiceTask});

  final ChoiceTask choiceTask;

  @override
  State<ChoiceTaskWidget> createState() => _ChoiceTaskWidgetState();
}

class _ChoiceTaskWidgetState extends State<ChoiceTaskWidget> {
  ChoiceTaskOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
            children: widget.choiceTask.options
                .map((op) => buildOptionWidget(op))
                .toList()),
        Visibility(
          visible: selectedOption != null,
            child:
                ReadyConfirmationLabel(enabledNotifier: ValueNotifier(false)))
      ],
    );
  }

  Widget buildOptionWidget(ChoiceTaskOption option) {
    Widget child = Text(
      option.alternative,
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
