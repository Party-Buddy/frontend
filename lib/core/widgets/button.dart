import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = 200,
      this.fontSize = 20,
      this.padding = kPadding * 1.5});

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double padding;
  final double fontSize;

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
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: !_hovered ? kAppBarColor : darken(kAppBarColor, .05),
            borderRadius: kBorderRadius,
            boxShadow: !_hovered
                ? []
                : [
                    highlightShadow()
                  ]),
        padding: EdgeInsets.all(widget.padding),
        child: Text(
          widget.text,
          style: TextStyle(
              color: Colors.white, fontFamily: kFontFamily, fontSize: widget.fontSize),
        ),
      ),
    );
  }
}
