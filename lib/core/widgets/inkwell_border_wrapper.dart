import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class SelectableBorderWrapper extends StatefulWidget {
  const SelectableBorderWrapper({super.key, required this.child, required this.onPressed, this.padding = kPadding});

  final Widget child;
  final VoidCallback onPressed;
  final double padding;

  @override
  State<SelectableBorderWrapper> createState() =>
      _SelectableBorderWrapperState();
}

class _SelectableBorderWrapperState extends State<SelectableBorderWrapper> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onHover: (hovered) => setState(() {
              _hovered = hovered;
            }),
        onTap: widget.onPressed,
        borderRadius: kBorderRadius,
        child: AnimatedContainer(
          duration: kAnimationDuration,
          padding: EdgeInsets.all(widget.padding),
          decoration: BoxDecoration(
              color: kAppBarColor,
              borderRadius: kBorderRadius,
              boxShadow: !_hovered ? [] : [highlightShadow()]),
          child: widget.child,
        ));
  }
}
