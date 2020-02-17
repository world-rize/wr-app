// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';

import 'package:wr_app/ui/lesson/test_result_page.dart';

// TODO(wakame-tech): 遷移アニメーション
class PhraseSampleView extends StatelessWidget {
  const PhraseSampleView({@required this.phrase});
  final Phrase phrase;

  Widget _createPhraseSampleConversation() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8),
          child: Placeholder(fallbackHeight: 60),
        );
      },
      itemCount: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
  PhraseChoiceView({@required this.onTap});
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: InkWell(
                onTap: onTap,
                child: GFListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      'Choice $index',
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

class TestPage extends StatefulWidget {
  const TestPage({@required this.section});

  final Section section;

  @override
  State<StatefulWidget> createState() => TestPageState(section: section);
}

class TestPageState extends State<TestPage> {
  TestPageState({@required this.section});

  final Section section;

  int _index = 0;
  Phrase get currentPhrase => section.phrases[_index];

  @override
  void initState() {
    print(section.phrases);
    super.initState();
    _index = 0;
  }

  void _next() {
    // show result
//    showDialog(
//      context: context,
//      builder: (_) => Material(
//        type: MaterialType.transparency,
//        child: GestureDetector(
//          behavior: HitTestBehavior.opaque,
//          onTap: () {
//            Navigator.pop(context);
//          },
//          child: Center(
//            child: Container(
//              width: 100,
//              height: 100,
//              color: Colors.red,
//            ),
//          ),
//        ),
//      ),
//    );

    // seek index
    setState(() {
      _index++;
    });

    // test finish
    if (_index == section.phrases.length - 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TestResultPage(section: section)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Test'),
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
