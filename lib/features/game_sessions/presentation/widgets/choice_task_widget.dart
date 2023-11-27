import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';
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
                .toList())
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
      child: option == selectedOption
          ? BorderWrapper(shadow: true, child: child)
          : InkwellBorderWrapper(
              onPressed: () => setState(() => selectedOption = option),
              child: child),
    );
  }
}
