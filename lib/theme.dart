// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// アプリのUIスタイル
///
/// WIP
// TODO(wakame-tech): implement
final ThemeData wrThemeData = ThemeData(
  primaryColor: Colors.blueAccent.shade200,
  primaryTextTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
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
      fontSize: 24,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 18,
    ),
  ),
);
