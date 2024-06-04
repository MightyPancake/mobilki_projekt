import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xff4767ce);
const COLOR_BACKGROUND = Color(0xfff9fafd);
const COLOR_TITLE = Color(0xff191692);
const COLOR_TEXT = Color(0xff181818);
const COLOR_SECONDARY = Color(0xff9db3f9);
const COLOR_THIRD = Color(0xffe8ebf9);
const COLOR_GREY = Color(0xffb6b6b9);

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
