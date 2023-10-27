import 'package:flutter/widgets.dart';

const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
final kShadowColor = const Color(0xFFD3D3D3).withOpacity(.84);

const kFontFamily = "Roboto";
const kFontColor = Color.fromARGB(255, 255, 198, 245);

const kInputLabelBackgroundColor = Color.fromARGB(255, 71, 1, 73);

const kBackgorundColor = Color.fromARGB(255, 39, 1, 56);
const kBorderColor = Color.fromARGB(255, 245, 96, 230);
final kFillColor = const Color.fromARGB(255, 71, 1, 73).withOpacity(.8);

const kButtonColor = Color.fromARGB(255, 246, 180, 180);
const kButtonShadowColor = Color.fromARGB(255, 189, 103, 235);

const kPadding = 10.0;
const kPaddingAll = EdgeInsets.all(kPadding);

const kRadius = 10.0;
const kBorderRadius = BorderRadius.all(Radius.circular(kRadius));
const kAnimationDuration = Duration(milliseconds: 100);

const kBackgroundGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color.fromARGB(255, 30, 30, 30),
    Color.fromARGB(255, 53, 2, 81),
    Color.fromARGB(255, 30, 30, 30),
  ],
);
