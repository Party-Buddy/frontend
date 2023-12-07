import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class BorderWrapper extends StatelessWidget {
  const BorderWrapper(
      {super.key,
      required this.child,
      this.padding = kPadding,
      this.fillColor,
      this.borderColor,
      this.shadowColor = kPrimaryColor,
      this.shadow = false,
      this.blurRadius = 12.0});

  final Widget child;
  final double padding;
  final Color? fillColor;
  final Color shadowColor;
  final bool shadow;
  final Color? borderColor;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            color: fillColor ?? kAppBarColor,
            border: Border.all(color: borderColor?? Colors.transparent, width: 1.5),
            boxShadow: shadow ? [highlightShadow(color: shadowColor, blurRadius: blurRadius)] : []),
        padding: EdgeInsets.all(padding),
        child: child);
  }
}
