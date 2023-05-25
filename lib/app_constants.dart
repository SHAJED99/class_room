// Colors
import 'package:flutter/material.dart';

const String appTitle = "Class Room";
const String appSubtitle = "This is a dummy app";
const String appVersion = "1.0.0";

const MaterialColor defaultPrimarySwatch = MaterialColor(
  0xFF07AEAF,
  <int, Color>{
    50: Color(0xFFE2F7F8),
    // 100: Color(0xFFB6E7E8),
    100: Color.fromARGB(80, 182, 231, 232),
    200: Color(0xFF84D6D7),
    300: Color(0xFF52C5C5),
    400: Color(0xFF2FBABD),
    500: Color(0xFF07AEAF),
    600: Color(0xFF059B9C),
    700: Color(0xFF038786),
    800: Color(0xFF016B70),
    900: Color(0xFF004D5A),
  },
);
const Color defaultBlackColor = Color(0xFF505050);
// const Color defaultBlackColor = Color.fromARGB(30, 182, 231, 232);
const Color defaultWhiteColor = Color(0xFFFAFAFA);
const Color defaultGreyColor = Color(0xFFC0C2C9);
const Color defaultErrorColor = Colors.redAccent;

// Time
const defaultDuration = 300;

// Text
const TextStyle defaultTitleStyle1 = TextStyle(
  height: 1,
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: defaultBlackColor,
);
const TextStyle defaultSubtitle1 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: defaultGreyColor,
);
const TextStyle defaultSubtitle2 = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w700,
  color: defaultGreyColor,
  height: 1,
);
const TextStyle buttonText1 = TextStyle(
  fontSize: 16,
  height: 1,
  fontWeight: FontWeight.bold,
  color: defaultWhiteColor,
);

// Box Size
const double defaultPadding = 16;
const double defaultMaxWidth = 400;
const double defaultNavBarHeight = 16 * 3.5;
const double defaultBoxHeight = 16 * 3;
const double defaultCarouselHeight = 16 * 11;

// Box Shadow
const List<BoxShadow> defaultBoxShadowUp = [
  BoxShadow(
    color: defaultGreyColor,
    offset: Offset(0, 0),
    blurRadius: 2,
  )
];
const List<BoxShadow> defaultBoxShadowDown = [
  BoxShadow(
    color: defaultGreyColor,
    offset: Offset(0, 2),
    blurRadius: 1,
  )
];
