import 'package:flutter/material.dart';

class AgencyPage extends StatelessWidget {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '留学先紹介',
          style: optionStyle,
        ),
      ],
    );
  }
}
