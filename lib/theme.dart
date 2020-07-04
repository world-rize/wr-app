// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// アプリのUIスタイル
// TODO(high): implement
final ThemeData WorldRizeLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blueAccent.shade200,
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
);

final ThemeData WorldRizeDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueAccent.shade200,
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
);
