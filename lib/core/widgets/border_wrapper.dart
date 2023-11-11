import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class BorderWrapper extends StatelessWidget {
  const BorderWrapper(
      {super.key,
      required this.child,
      this.padding = kPadding,
      this.fillColor});

  final Widget child;
  final double padding;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: kAnimationDuration,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: kBorderRadius, color: fillColor?? kAppBarColor),
        padding: EdgeInsets.all(padding),
        child: child);
  }
}
