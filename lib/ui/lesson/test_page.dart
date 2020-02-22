// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';

import 'package:wr_app/ui/lesson/test_result_page.dart';

// TODO(wakame-tech): 遷移アニメーション
class QuestionView extends StatelessWidget {
  const QuestionView(
      {@required this.phrase, @required this.selection, @required this.onNext});

  final Phrase phrase;
  final List<String> selection;
  final void Function() onNext;

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

  Widget _createSelection() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: InkWell(
              onTap: onNext,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // title
        ListTile(
          title: Text(
            phrase.japanese,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
        ),
        // sample
        SizedBox(
          height: 240,
          child: _createPhraseSampleConversation(),
        ),
        // selection
        SizedBox(
          height: 350,
          child: _createSelection(),
        ),
      ],
    );
  }
}

//class TestStoryPageState extends State<TestPage> {
//  TestStoryPageState({@required this.section});
//
//  final Section section;
//  final _storyController = StoryController();
//
//  @override
//  Widget build(BuildContext context) {
//    final dummySelection = [
//      'When is the homework due?',
//      'When is the homework due?',
//      'When is the homework due?',
//      'When is the homework due?',
//    ];
//
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.blue,
//          title: const Text('Test'),
//        ),
//        body: StoryView(
//          section.phrases
//              .map(
//                (phrase) => StoryItem(
//                  QuestionView(
//                    phrase: phrase,
//                    selection: dummySelection,
//                    onNext: () {},
//                  ),
//                ),
//              )
//              .toList(),
//          controller: _storyController,
//          inline: true,
//          onStoryShow: (item) {
//            print('story show');
//          },
//          onComplete: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                  builder: (_) => TestResultPage(section: section)),
//            );
//          },
//        ));
//  }
//}

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
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Image.network(
                'https://lh4.googleusercontent.com/proxy/NSEhjqnplbvFpayOYa5fKRT8ky2NnOLW8N7vWW0kHqjNs46lUE05KP7y6rTm1qggHRbK_xlHxiHYDzIgBxqSGJ2bnJL02NejzQ=s0-d'),
          ),
        ),
      ),
    );

    // test finish
    if (_index == section.phrases.length - 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TestResultPage(section: section)),
      );
    } else {
      // seek index
      setState(() {
        _index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dummySelection = [
      'When is the homework due?',
      'When is the homework due?',
      'When is the homework due?',
      'When is the homework due?',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            QuestionView(
                phrase: currentPhrase,
                selection: dummySelection,
                onNext: _next),
          ],
        ),
      ),
    );
  }
}
