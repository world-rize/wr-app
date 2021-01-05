// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

// 色
class Palette {
  void _;

  static const Color symbolColor = Color(0xff56c0ea);
  static const Color correctColor = Color(0xff77ff36);
  static const Color inCorrectColor = Color(0xffff5757);
}

/// アプリのUIスタイル
// TODO(high): implement
final ThemeData wrLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Palette.symbolColor,
  accentColor: Colors.black,
  backgroundColor: Colors.white,
  primaryIconTheme: const IconThemeData(color: Colors.white),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  ),
);

final ThemeData wrDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Palette.symbolColor,
  accentColor: Colors.white,
  backgroundColor: Colors.black45,
  primaryIconTheme: const IconThemeData(color: Colors.white),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
);