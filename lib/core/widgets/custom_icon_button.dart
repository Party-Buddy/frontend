import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.onPressed, required this.iconData});

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkwellBorderWrapper(
        onPressed: onPressed,
        child: Icon(
          iconData,
          color: kPrimaryColor,
        ));
  }
}
