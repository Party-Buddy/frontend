import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});
  
  @override
  State<CustomCheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

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
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
