import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class SwitchBorderWrapper extends StatefulWidget {
  const SwitchBorderWrapper(
      {super.key,
      required this.onChanged,
      required this.child,
      this.shadowColor = kPrimaryColor,
      this.initialEnabled = false});

  final Widget child;
  final Color shadowColor;
  final bool initialEnabled;
  final void Function(bool) onChanged;

  @override
  State<SwitchBorderWrapper> createState() => _SwitchBorderWrapperState();
}

class _SwitchBorderWrapperState extends State<SwitchBorderWrapper> {
  late bool enabled = widget.initialEnabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        enabled = !enabled;
        widget.onChanged(enabled);
      }),
      borderRadius: kBorderRadius,
      child: AnimatedContainer(
          duration: kAnimationDuration,
          decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: kAppBarColor,
              boxShadow:
                  enabled ? [highlightShadow(color: widget.shadowColor)] : []),
          padding: kPaddingAll,
          child: widget.child),
    );
  }
}
