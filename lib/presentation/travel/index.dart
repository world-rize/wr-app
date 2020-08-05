// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:ui';

import 'package:flutter/material.dart';

/// `旅行` ページのトップ
///
class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/mock.png',
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: const Color(0).withOpacity(0),
            ),
          ),
        ),
        Container(
          child: Center(
            child: Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 30,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
