import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Muli',
      appBarTheme: appBarTheme(),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: kPrimaryColor.withOpacity(.5)));
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kAppBarColor,
    elevation: 7,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
    iconTheme: const IconThemeData(color: kPrimaryColor),
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
      icon:
          const Icon(Icons.arrow_back_ios_new, size: 20, color: kPrimaryColor));
}

InputDecoration inputDecoration({String? labelText, Color? fillColor}) {
  return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: fillColor ?? kAppBarColor,
      labelStyle: const TextStyle(color: kFontColor, fontFamily: kFontFamily),
      enabledBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: kAppBarColor)),
      border: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: kAppBarColor)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: kPrimaryColor)));
}

Border border() => Border.all(color: kBorderColor, width: 1);

TextStyle defaultTextStyle({double fontSize = 18, Color color = kFontColor}) {
  return TextStyle(fontFamily: kFontFamily, fontSize: fontSize, color: color);
}

BoxShadow highlightShadow(
        {Color color = const Color.fromARGB(255, 255, 89, 227),
        double blurRadius = 15.0}) =>
    BoxShadow(color: color, blurRadius: blurRadius);
