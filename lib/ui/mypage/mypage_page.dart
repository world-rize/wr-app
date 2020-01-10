import 'package:flutter/material.dart';

class MyPagePage extends StatelessWidget {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'マイページ',
          style: optionStyle,
        ),
      ],
    );
  }
}
