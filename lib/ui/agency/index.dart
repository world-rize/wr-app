// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getflutter/components/typography/gf_typography.dart';
import 'package:getflutter/getflutter.dart';

/// `留学先紹介` ページのトップ
class AgencyIndexPage extends StatelessWidget {
  static final _headLineStyle = TextStyle(
    fontSize: 30,
    color: Colors.black54,
    fontWeight: FontWeight.bold,
  );

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
