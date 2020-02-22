// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';

import 'package:wr_app/ui/lesson/test_result_page.dart';

/// テストページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469139>
class TestPage extends StatefulWidget {
  const TestPage({@required this.section});

  final Section section;

  @override
  State<StatefulWidget> createState() => TestPageState(section: section);
}

/// [TestPage] の State
class TestPageState extends State<TestPage> {
  TestPageState({@required this.section});

  /// 出題されるセクション
  final Section section;

  /// 現在の問題番号
  int _index = 0;

  /// 現在の問題
  Phrase get currentPhrase => section.phrases[_index];

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  /// 次の問題へ
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
    // 問題の選択肢
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

// TODO(wakame-tech): 遷移アニメーション
/// 問題画面
///
/// [phrase] と [selection] を表示し選択されたら [onNext] がコールバックされる
class QuestionView extends StatelessWidget {
  const QuestionView(
      {@required this.phrase, @required this.selection, @required this.onNext});

  /// フレーズ
  final Phrase phrase;

  /// 選択肢
  final List<String> selection;

  /// コールバック
  final void Function() onNext;

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

  /// 会話例
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

  /// 選択肢
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
}

/// テストをストーリ風に表示するUI(experimental)
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
