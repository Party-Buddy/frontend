import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';

class OptionSwitcher<T> extends StatefulWidget {
  const OptionSwitcher(
      {super.key,
      required this.options,
      required this.onTap,
      required this.initialOption,
      required this.stringMapper,
      this.minOptionWidth = 100});

  final List<T> options;
  final void Function(T) onTap;
  final String Function(T) stringMapper;
  final T initialOption;
  final double minOptionWidth;

  @override
  State<OptionSwitcher<T>> createState() => _OptionSwitcherState();
}

class _OptionSwitcherState<T> extends State<OptionSwitcher<T>> {
  late T current = widget.initialOption;

  @override
  Widget build(BuildContext context) {
    return BorderWrapper(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.options
          .map((o) => InkwellBorderWrapper(
              padding: 5,
              fillColor: current == o ? darken(kPrimaryColor, 0.3) : darken(kAppBarColor, 0.05),
              child: Container(
                width: widget.minOptionWidth,
                alignment: Alignment.center,
                child: Text(
                  widget.stringMapper(o),
                  style: defaultTextStyle(fontSize: 16),
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.onTap(o);
                  current = o;
                });
              }))
          .toList(),
    ));
  }
}
