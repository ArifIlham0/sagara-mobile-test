import 'package:flutter/material.dart';

const Color kPurple = Color(0xFF676BD0);
const Color kDarkPurple = Colors.deepPurple;
const Color kWhite = Colors.white;

class ThemeClass {
  static ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: kPurple,
    ),
  );
  static ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: kPurple,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
