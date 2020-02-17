// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class ColumnIndexPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Text(
          'コラム',
          style: optionStyle,
        ),
      ],
    );
  }
}
