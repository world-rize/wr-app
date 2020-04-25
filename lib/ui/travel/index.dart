// Copyright © 2020 WorldRIZe. All rights reserved.

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
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // This makes the blue container full width.
              Expanded(
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Coming Soon",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

//    return SingleChildScrollView(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: const <Widget>[
//          // map
//          Padding(
//            padding: EdgeInsets.all(10),
//            child: Text(
//              'Map',
//              style: _headLineStyle,
//            ),
//          ),
//          Placeholder(
//            fallbackHeight: 150,
//          ),
//
//          // 今月のおすすめ
//          Padding(
//            padding: EdgeInsets.all(10),
//            child: Text(
//              '今月のおすすめ',
//              style: _headLineStyle,
//            ),
//          ),
//          Placeholder(
//            fallbackHeight: 200,
//          ),
//
//          // あなたにおすすめ
//          Padding(
//            padding: EdgeInsets.all(10),
//            child: Text(
//              'あなたにおすすめ',
//              style: _headLineStyle,
//            ),
//          ),
//          Placeholder(
//            fallbackHeight: 200,
//          ),
//        ],
//      ),
//    );
  }
}
