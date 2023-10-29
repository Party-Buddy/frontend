import 'package:flutter/widgets.dart';

const kFontFamily = "Roboto";
const kFontColor = Color.fromARGB(255, 255, 226, 250);

const kInputLabelBackgroundColor = Color.fromARGB(255, 71, 1, 73);

const kPrimaryColor = Color.fromARGB(255, 89, 247, 150);//Color.fromARGB(255, 247, 89, 239);
Color get kAppBarColor => darken(kPrimaryColor, .45);
Color get kBackgorundColor => darken(kPrimaryColor, .9);
Color get kBorderColor => kPrimaryColor;
Color get kFillColor => darken(kPrimaryColor, .4);

Color get kButtonColor => darken(kPrimaryColor, .2);
Color get kButtonShadowColor => darken(kButtonColor, .2);

const kPadding = 10.0;
const kPaddingAll = EdgeInsets.all(kPadding);

const kRadius = 10.0;
const kBorderRadius = BorderRadius.all(Radius.circular(kRadius));
const kAnimationDuration = Duration(milliseconds: 100);

Gradient get kBackgroundGradient => LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color.fromARGB(255, 30, 30, 30),
    darken(kPrimaryColor, .5),
    Color.fromARGB(255, 30, 30, 30),
  ],
);

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
