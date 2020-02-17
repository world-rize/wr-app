// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/phrase.dart';

class LessonPhrasesDetailPage extends StatelessWidget {
  final Phrase phrase;

  LessonPhrasesDetailPage({@required this.phrase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Phrase Detail'),
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
