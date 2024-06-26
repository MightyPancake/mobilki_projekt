import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xff4767ce);
const COLOR_BACKGROUND = Color(0xfff9fafd);
const COLOR_TITLE = Color(0xff191692);
const COLOR_TEXT = Color(0xff181818);
const COLOR_SECONDARY = Color(0xff9db3f9);
const COLOR_THIRD = Color(0xffe8ebf9);
const COLOR_GREY = Color(0xffb6b6b9);

const COLOR_TAG_PINK = Color(0xfff52768);
const COLOR_TAG_PURPLE = Color(0xff790c9f);
const COLOR_TAG_GREEN = Color(0xff0c9f35);
const COLOR_TAG_YELLOW = Color(0xfff5af27);
const COLOR_TAG_BLUE = Color(0xff1ad1dd);

ThemeData myTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme().apply(
      bodyColor: COLOR_TEXT, 
      displayColor: COLOR_TEXT, 
      fontFamily: 'Montserrat',
    ),
  colorScheme: const ColorScheme.light(
    primary: COLOR_PRIMARY,
    inversePrimary: COLOR_TITLE, // title color
    secondary: COLOR_SECONDARY,
    tertiary: COLOR_THIRD,
    surface: COLOR_BACKGROUND,
    outline: COLOR_TEXT,
    shadow: COLOR_GREY,
  )
);


TextStyle titleStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w600,
  fontFamily: 'Montserrat',
  color: myTheme.colorScheme.inversePrimary,
);

TextStyle displayFriendNameStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  fontFamily: 'Montserrat',
  color: myTheme.colorScheme.inversePrimary,
);

TextStyle paragraphStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  fontFamily: 'Asap',
  color: myTheme.colorScheme.outline,
);

TextStyle toolbarTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  fontFamily: 'Montserrat',
  color: myTheme.colorScheme.surface,
);

TextStyle tagTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: 'Montserrat',
  color: myTheme.colorScheme.surface,
);

TextStyle smallTagTextStyle = TextStyle(
  fontSize: 4,
  fontWeight: FontWeight.w500,
  fontFamily: 'Montserrat',
  color: myTheme.colorScheme.surface,
);

var tagColors = {
  "przyjaciel": COLOR_TAG_PINK,
  "praca": COLOR_TAG_PURPLE,
  "rodzina": COLOR_TAG_GREEN,
  "znajomy": COLOR_TAG_YELLOW,
  "sąsiad": COLOR_TAG_BLUE,
};

var tagColorsSelected = {
  "przyjaciel": Color(0xffc51d55), // darker shade of #f52768
  "praca": Color(0xff5e087f), // darker shade of #790c9f
  "rodzina": Color(0xff0a7f2b), // darker shade of #0c9f35
  "znajomy": Color(0xffc48821), // darker shade of #f5af27
  "sąsiad": Color(0xff159fae), // darker shade of #1ad1dd
};