// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/test_result_page.dart';

class TestPage extends StatelessWidget {
  final Section section;

  TestPage({this.section});

  Widget _createPhraseSampleConversation() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Placeholder(fallbackHeight: 80),
        );
      },
      itemCount: 3,
    );
  }

  Widget _createPhraseSample() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            const ListTile(
              title: Text(
                'タイトル',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: _createPhraseSampleConversation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createPhraseChoices(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TestResultPage()),
                  );
                },
                child: Placeholder(fallbackHeight: 65),
              ),
            );
          },
          itemCount: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _createPhraseSample(),
            _createPhraseChoices(context),
          ],
        ),
      ),
    );
  }
}
