import 'package:flutter/material.dart';

class ColumnPage extends StatelessWidget {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'コラム',
          style: optionStyle,
        ),
      ],
    );
  }
}
