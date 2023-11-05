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
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hovered) => setState(() {
        _hovered = hovered;
      }),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !_hovered ? Colors.blueGrey.shade900 :
            Colors.grey.shade900,
          borderRadius: kBorderRadius,
          boxShadow: !_hovered
            ? []
            : [
              const BoxShadow(
                color: Color.fromARGB(255, 255, 89, 227),
                blurRadius: 15
              )
              ]
        ),
        padding: const EdgeInsets.all(kPadding * 1.5),
        margin: const EdgeInsets.all(kPadding / 4),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: kFontFamily,
            fontSize: 20
          ),
        ),
      ),
    );
  }
}
