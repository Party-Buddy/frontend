import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Muli',
      appBarTheme: appBarTheme(),
      textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color.fromARGB(255, 197, 18, 228)));
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color.fromARGB(255, 94, 0, 128),
    elevation: 7,
    centerTitle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
    iconTheme: IconThemeData(color: kFontColor),
    titleTextStyle:
        TextStyle(color: kFontColor, fontSize: 20, fontFamily: kFontFamily),
  );
}

Widget backButton(BuildContext context) {
  return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: kFontColor));
}

InputDecoration inputDecoration({String? labelText, Color? borderColor}) {
  return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.transparent,
      labelStyle: const TextStyle(color: kFontColor, fontFamily: kFontFamily),
      enabledBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: borderColor ?? kBorderColor)),
      border: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: borderColor ?? kBorderColor)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 191, 237))));
}

Border border() => Border.all(color: kBorderColor, width: 1);

Widget borderWrapper(Widget child, {double padding = 10.0, Color? fillColor}) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: kBorderRadius, color: fillColor, border: border()),
      padding: EdgeInsets.all(padding),
      child: child);
}

TextStyle standardTextStyle({double fontSize = 18}) {
  return TextStyle(
      fontFamily: kFontFamily, fontSize: fontSize, color: kFontColor);
}
