import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/custom_check_box.dart';

class ReadyConfirmationLabel extends StatelessWidget {
  const ReadyConfirmationLabel({super.key, required this.enabledNotifier});

  final ValueNotifier<bool> enabledNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: kPaddingAll,
      child: Row(
        children: [
          Text(
            "Подтвердить готовность",
            style: defaultTextStyle(),
          ),
          const SizedBox(
            width: kPadding,
          ),
          CustomCheckBox(enabledNotifier: enabledNotifier,)
        ],
      ),
    );
  }
}
