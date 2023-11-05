import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Muli',
      appBarTheme: appBarTheme(),
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: kPrimaryDarkColor));
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kAppBarColor,
    elevation: 7,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
    iconTheme: const IconThemeData(color: kFontColor),
    titleTextStyle: const TextStyle(
        color: kFontColor, fontSize: 20, fontFamily: kFontFamily),
  );
}

DecorationImage standardDecorationImage({BoxFit fit = BoxFit.cover}) =>
    DecorationImage(
        image: const AssetImage("assets/images/background.jpg"), fit: fit);

IconButton backButton(BuildContext context) {
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
      focusedBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: lighten(kPrimaryDarkColor, .2))));
}

Border border() => Border.all(color: kBorderColor, width: 1);

TextStyle defaultTextStyle({double fontSize = 18}) {
  return TextStyle(
      fontFamily: kFontFamily, fontSize: fontSize, color: kFontColor);
}
