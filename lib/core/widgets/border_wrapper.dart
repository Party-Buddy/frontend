import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class BorderWrapper extends StatelessWidget {
  const BorderWrapper(
      {super.key,
      required this.child,
      this.padding = kPadding,
      this.fillColor,
      this.border,
      this.shadowColor = kPrimaryColor,
      this.shadow = false});

  final Widget child;
  final double padding;
  final Color? fillColor;
  final Color shadowColor;
  final bool shadow;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            color: fillColor ?? kAppBarColor,
            border: border,
            boxShadow: shadow ? [highlightShadow(color: shadowColor)] : []),
        padding: EdgeInsets.all(padding),
        child: child);
  }
}
