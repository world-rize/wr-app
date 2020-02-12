// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/phrase.dart';

class LessonPhrasesDetailPage extends StatelessWidget {
  final Phrase phrase;

  LessonPhrasesDetailPage({this.phrase});

  Widget _createPhraseSampleConversation() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "dummy",
          )
        );
      },
      itemCount: 4,
    );
  }

  Widget _createPhraseSample() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                phrase.japanese,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              child: _createPhraseSampleConversation(),
            ),
          ],
        ),
      ),
    );
  }

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
            _createPhraseSample(),
          ],
        ),
      ),
    );
  }
}
