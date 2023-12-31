import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Muli',
      appBarTheme: appBarTheme(),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: kPrimaryColor
      ),
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
          borderSide: BorderSide(color: kAppBarColor, width: 2)),
      border: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: kAppBarColor, width: 2)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: kPrimaryColor, width: 2)));
}

Border border() => Border.all(color: kBorderColor, width: 1);

TextStyle defaultTextStyle({double fontSize = 18, Color color = kFontColor}) {
  return TextStyle(fontFamily: kFontFamily, fontSize: fontSize - 2, color: color);
}

BoxShadow highlightShadow(
        {Color color = kPrimaryColor,
        double blurRadius = 12.0}) =>
    BoxShadow(color: color, blurRadius: blurRadius);
