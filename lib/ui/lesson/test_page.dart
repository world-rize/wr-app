// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';

import 'package:wr_app/ui/lesson/test_result_page.dart';

class PhraseSampleView extends StatelessWidget {
  final Phrase phrase;
  PhraseSampleView({this.phrase});

  Widget _createPhraseSampleConversation() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Placeholder(fallbackHeight: 60),
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
              height: 240,
              child: _createPhraseSampleConversation(),
            ),
          ],
        ),
      ),
    );
  }
}

class PhraseChoiceView extends StatelessWidget {
  void Function() onTap;
  PhraseChoiceView({this.onTap});

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
                onTap: onTap,
                child: GFListTile(
                  title: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      'When is the homework due?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  color: Colors.lightBlueAccent,
                )),
          );
        },
        itemCount: 4,
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  // FIXME: bad code
  BuildContext _context;

  final Section section;
  TestPage({this.section});

  int _index = 0;
  Phrase get currentPhrase => section.phrases[_index];

  void _next() {
    print(_index++);
    if (_index == section.phrases.length - 1) {
      Navigator.of(_context).push(
        MaterialPageRoute(builder: (_) => TestResultPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PhraseSampleView(phrase: currentPhrase),
            PhraseChoiceView(onTap: _next),
          ],
        ),
      ),
    );
  }
}
