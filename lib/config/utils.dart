import 'package:flutter/material.dart';
import 'theme/commons.dart';
import 'view_config.dart';

void showMessage(BuildContext context, message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              borderWrapper(
                  Text(message,
                      style: const TextStyle(
                          color: kFontColor,
                          fontFamily: kFontFamily,
                          fontSize: 18)),
                  padding: 15.0,
                  fillColor: darken(kPrimaryColor, .6))
            ]),
          ));
}
