import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class InkwellBorderWrapper extends StatefulWidget {
  const InkwellBorderWrapper(
      {super.key,
      required this.child,
      required this.onPressed,
      this.padding = kPadding,
      this.fillColor,
      this.enableShadow = true});

  final Widget child;
  final VoidCallback onPressed;
  final double padding;
  final Color? fillColor;
  final bool enableShadow;

  @override
  State<InkwellBorderWrapper> createState() => _InkwellBorderWrapperState();
}

class _InkwellBorderWrapperState extends State<InkwellBorderWrapper> {
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
              color: widget.fillColor ?? kAppBarColor,
              borderRadius: kBorderRadius,
              boxShadow: !_hovered || !widget.enableShadow
               ? [] : [highlightShadow()]),
          child: widget.child,
        ));
  }
}
