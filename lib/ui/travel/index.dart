// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class TravelPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '旅行',
          style: optionStyle,
        ),
      ],
    );
  }
}
