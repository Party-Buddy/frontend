import 'package:flutter/widgets.dart';

const kFontFamily = "Roboto";
const kFontColor = Color.fromARGB(255, 255, 226, 250);

const kInputLabelBackgroundColor = Color.fromARGB(255, 71, 1, 73);


// const kPrimaryColor = Color.fromARGB(255, 63, 242, 255);
const kPrimaryColor = Color.fromARGB(255, 255, 89, 227);
const kPrimaryDarkColor = Color.fromARGB(255, 175, 163, 175);//Color.fromARGB(255, 247, 89, 239);
Color get kAppBarColor => darken(kPrimaryDarkColor, .45);
Color get kBackgorundColor => kPrimaryDarkColor.withOpacity(.25);
Color get kBorderColor => kPrimaryDarkColor;
Color get kFillColor => darken(kPrimaryDarkColor, .4);

Color get kButtonColor => darken(kPrimaryDarkColor, .2);
Color get kButtonShadowColor => darken(kButtonColor, .2);

const kPadding = 10.0;
const kPaddingAll = EdgeInsets.all(kPadding);

const kRadius = 10.0;
const kBorderRadius = BorderRadius.all(Radius.circular(kRadius));
const kAnimationDuration = Duration(milliseconds: 100);

var kBackgroundGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    darken(kPrimaryColor, .55),
    darken(kPrimaryColor, .7),
    darken(kPrimaryColor, .8),
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
