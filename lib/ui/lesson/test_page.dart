// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/extension/collection_extension.dart';
import 'package:wr_app/extension/padding_extension.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/ui/lesson/test_result_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_example.dart';

/// テストページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469139>
class TestPage extends StatefulWidget {
  const TestPage({@required this.section});

  final Section section;

  @override
  State<StatefulWidget> createState() => TestPageState(section: section);
}

class TestStats {
  TestStats({
    @required this.section,
    @required this.answers,
    this.questions = 7,
    this.corrects = 0,
  });

  Section section;
  int questions;
  int corrects;
  List<bool> answers;
}

/// [TestPage] の State
class TestPageState extends State<TestPage> {
  TestPageState({@required this.section});

  /// 出題されるセクション
  final Section section;

  /// 現在の問題番号
  int _index = 0;

  /// 正解のindex
  int _answerIndex = 0;

  /// 正解数
  int _corrects = 0;

  /// 選択
  List<bool> _answers;

  /// 現在の問題
  Phrase get currentPhrase => section.phrases[_index];

  @override
  void initState() {
    super.initState();
    _index = 0;
    _answers = [];
  }

  /// 次の問題へ
  // TODO: リファクタリング
  Future<void> _next(int answer) async {
    _answers.add(answer == _answerIndex);

    // show result
    if (answer == _answerIndex) {
      _corrects += 1;
      // _showQuestionResult(correct: true);
    } else {
      // _showQuestionResult(correct: false);
    }

    // test finish
    if (_index == section.phrases.length - 1) {
      final stats = TestStats(
        section: section,
        questions: 7,
        corrects: _corrects,
        answers: _answers,
      );

      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TestResultPage(stats: stats)),
      );
    } else {
      // seek index
      setState(() {
        _index++;
      });
    }
  }

  List<String> _randomSelections() {
    final selections = Provider.of<MasterDataStore>(context)
        .allPhrases()
        .sample(4)
        .map((phrase) => phrase.title['en'])
        .toList();
    _answerIndex = Random().nextInt(4);
    selections[_answerIndex] = currentPhrase.title['en'];
    return selections;
  }

  void _showConfirmDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testInterrupt),
        content: Text(I.of(context).testInterruptDetail),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I.of(context).yes),
            onPressed: () {
              // pop dialog
              Navigator.pop(context);
              // pop this view
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: Text(I.of(context).no),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

//  void _showQuestionResult({bool correct}) {
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
//            child: Image.network(correct
//                ? 'https://4.bp.blogspot.com/-CUR5NlGuXkU/UsZuCrI78dI/AAAAAAAAc20/mMqQPb9bBI0/s800/mark_maru.png'
//                : 'https://1.bp.blogspot.com/-eJGNGE4u8LA/UsZuCAMuehI/AAAAAAAAc2c/QQ5eBSC2Ey0/s800/mark_batsu.png'),
//          ),
//        ),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final selection = _randomSelections();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(I.of(context).question(_index + 1)),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _showConfirmDialog,
          )
        ],
      ),
      body: QuestionView(
        index: _index,
        phrase: currentPhrase,
        selection: selection,
        onNext: _next,
      ),
    );
  }
}

// TODO(someone): 遷移アニメーション
/// 問題画面
///
/// [phrase] と [selection] を表示し選択されたら [onNext] がコールバックされる
class QuestionView extends StatelessWidget {
  const QuestionView({
    @required this.index,
    @required this.phrase,
    @required this.selection,
    @required this.onNext,
  });

  /// index
  final int index;

  /// フレーズ
  final Phrase phrase;

  /// 選択肢
  final List<String> selection;

  /// コールバック
  final void Function(int) onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 5,
          child: PhraseSampleView(
            example: phrase.example,
            showKeyphrase: false,
          ),
        ),
        Flexible(
          flex: 3,
          child: _createSelection(),
        ),
      ],
    );
  }

  /// 選択肢
  Widget _createSelection() {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            onNext(index);
          },
          child: GFListTile(
            title: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                selection[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            color: Colors.lightBlueAccent,
          ),
        ).p(6);
      },
      itemCount: 4,
    );
  }
}
