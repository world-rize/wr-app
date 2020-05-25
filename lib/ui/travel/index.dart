// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:ui';

import 'package:flutter/material.dart';

/// `旅行` ページのトップ
///
class TravelPage extends StatelessWidget {
  static const _headLineStyle = TextStyle(
    fontSize: 30,
    color: Colors.black54,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        SingleChildScrollView(
//          physics: const NeverScrollableScrollPhysics(),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: const <Widget>[
//              // map
//              Padding(
//                padding: EdgeInsets.all(10),
//                child: GFTypography(
//                  text: 'Map',
//                  type: GFTypographyType.typo1,
//                  dividerColor: GFColors.SUCCESS,
//                ),
//              ),
//              Placeholder(
//                fallbackHeight: 150,
//              ),
//
//              // 今月のおすすめ
//              Padding(
//                padding: EdgeInsets.all(10),
//                child: Text(
//                  '今月のおすすめ',
//                  style: _headLineStyle,
//                ),
//              ),
//              Placeholder(
//                fallbackHeight: 200,
//              ),
//
//              // あなたにおすすめ
//              Padding(
//                padding: EdgeInsets.all(10),
//                child: Text(
//                  'あなたにおすすめ',
//                  style: _headLineStyle,
//                ),
//              ),
//              Placeholder(
//                fallbackHeight: 200,
//              ),
//            ],
//          ),
//        ),
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
