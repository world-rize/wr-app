// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/notifier/lesson_notifier.dart';
import 'package:wr_app/presentation/lesson/widgets/test_choices.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/extensions.dart';

import './test_result_page.dart';

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
  // TODO: refactoring
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

      await sendEvent(event: AnalyticsEvent.finishTest);

      Navigator.of(context).pop();

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

  List<String> _randomSelections() {
    final notifier = Provider.of<LessonNotifier>(context);
    final selections =
        notifier.phrases.sample(4).map((phrase) => phrase.title['en']).toList();
    _answerIndex = Random().nextInt(4);
    selections[_answerIndex] = currentPhrase.title['en'];
    return selections;
  }

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
      body: TestChoices(
        index: _index,
        phrase: currentPhrase,
        selection: selection,
        onNext: _next,
      ),
    );
  }
}