// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class AgencyIndexPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Text(
          '留学先紹介',
          style: optionStyle,
        ),
      ],
    );
  }
}
