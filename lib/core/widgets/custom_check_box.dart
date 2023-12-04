import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key, required this.enabledNotifier});

  final ValueNotifier<bool> enabledNotifier;
  
  @override
  State<CustomCheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CustomCheckBox> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey.shade700;
      }
      return kBackgorundColor;
    }

    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
        checkColor: kPrimaryColor,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: widget.enabledNotifier.value,
        onChanged: (bool? value) {
          setState(() {
            widget.enabledNotifier.value = !widget.enabledNotifier.value;
          });
        },
      ),
    );
  }
}
