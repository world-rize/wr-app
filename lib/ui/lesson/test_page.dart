// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase_sample.dart';

import 'package:wr_app/ui/lesson/test_result_page.dart';

class PhraseSampleView extends StatelessWidget {
  final PhraseSample sample;

  PhraseSampleView({this.sample});

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

  @override
  Widget build(BuildContext context) {
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
}

class PhraseChoiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TestResultPage()),
                    );
                  },
                  child: GFListTile(
                    title: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'When is the homework due?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    color: Colors.lightBlueAccent,
                  )),
            );
          },
          itemCount: 4),
    );
  }
}

class TestPage extends StatelessWidget {
  final Section section;

  TestPage({this.section});

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
            PhraseSampleView(),
            PhraseChoiceView(),
          ],
        ),
      ),
    );
  }
}
