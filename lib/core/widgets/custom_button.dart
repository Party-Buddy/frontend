import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = 200,
      this.fontSize = 20,
      this.bottomText,
      this.padding = kPadding});

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double padding;
  final double fontSize;
  final String? bottomText;

  @override
  Widget build(BuildContext context) {
    return InkwellBorderWrapper(
      onPressed: onPressed,
      padding: padding,
      child: Container(
        width: width,
        alignment: Alignment.center,
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: defaultTextStyle(
                color: Colors.white, fontSize: fontSize),
          ),
      ),
    );
  }
}
