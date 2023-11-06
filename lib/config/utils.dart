import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'view_config.dart';

void showMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              BorderWrapper(
                padding: 15.0,
                fillColor: darken(kPrimaryDarkColor, .6),
                child: Text(message,
                    style: const TextStyle(
                        color: kFontColor,
                        fontFamily: kFontFamily,
                        fontSize: 18)),
              )
            ]),
          ));
}

void showWidget(BuildContext context,
    {required Widget content, double padding = kPadding}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(0),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: darken(kPrimaryDarkColor, .6),
                ),
                child: content,
              )
            ]),
          ));
}

void showConfirmationDialog(BuildContext context,
    {String text = "Вы уверены?",
    String confirmText = "Да",
    required VoidCallback onConfirmed}) {
  showWidget(context,
      padding: kPadding * 2,
      content: Column(
        children: [
          Text(
            text,
            style: defaultTextStyle(),
          ),
          const SizedBox(
            height: kPadding * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  width: 100,
                  fontSize: 16,
                  padding: kPadding / 2,
                  text: "Отмена",
                  onPressed: () => Navigator.of(context).pop()),
              CustomButton(
                  width: 100,
                  fontSize: 16,
                  padding: kPadding / 2,
                  text: confirmText,
                  onPressed: onConfirmed)
            ],
          )
        ],
      ));
}
