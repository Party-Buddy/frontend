import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(220.0, 60.0)),
          padding: MaterialStateProperty.all(kPaddingAll),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: kBorderRadius,
          )),
          animationDuration: kAnimationDuration,
          side: MaterialStateProperty.all(BorderSide(
              color: kBorderColor, width: 1.0, style: BorderStyle.solid)),
          textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 18, fontFamily: kFontFamily)),
          overlayColor: MaterialStatePropertyAll(kFillColor.withOpacity(.8)),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: const MaterialStatePropertyAll(kFontColor)),
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
