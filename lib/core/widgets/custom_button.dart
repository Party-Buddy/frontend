import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = 200,
      this.fontSize = 20,
      this.padding = kPadding});

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double padding;
  final double fontSize;

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
            style: TextStyle(
                color: Colors.white, fontFamily: kFontFamily, fontSize: fontSize),
          ),
      ),
    );
  }
}
