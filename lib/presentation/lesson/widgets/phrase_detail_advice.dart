// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';

/// ワンポイントアドバイス
class PhraseDetailAdvice extends StatelessWidget {
  PhraseDetailAdvice({@required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                I.of(context).onePointAdvice,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
