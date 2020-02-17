// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:wr_app/model/phrase.dart';

class LessonPhrasesDetailPage extends StatelessWidget {
  const LessonPhrasesDetailPage({@required this.phrase});
  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Phrase Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(phrase.english),
          ],
        ),
      ),
    );
  }
}
