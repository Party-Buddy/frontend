import 'package:flutter/material.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
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

void showWidget(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(0),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              BorderWrapper(
                // padding: 0,
                fillColor: darken(kPrimaryDarkColor, .6),
                child: widget,
              )
            ]),
          ));
}
