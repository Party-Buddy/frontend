import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OptionSwitcher<T> extends StatelessWidget {
  const OptionSwitcher({super.key, required this.options, required this.onTap, required this.initialOption, this.minOptionWidth = 110});

  final List<T> options;
  final void Function(T) onTap;
  final T initialOption;
  final double minOptionWidth;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
        initialLabelIndex: options.indexOf(initialOption),
        totalSwitches: 2,
        borderColor: [kBorderColor],
        borderWidth: 1,
        minWidth: minOptionWidth,
        inactiveBgColor: darken(kPrimaryColor, .55),
        activeBgColor: [darken(kPrimaryColor, .4)],
        labels: const ['Your games', 'Public games'],
        customTextStyles: List.filled(2, defaultTextStyle(fontSize: 14)),
        onToggle: (index) {
          if (index == null) return;

          onTap(options[index]);
        }
      );
  }

}