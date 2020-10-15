// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/notifier/lesson_notifier.dart';
import 'package:wr_app/presentation/lesson/widgets/test_choices.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

import './test_result_page.dart';

class TestPageModel extends ChangeNotifier {
  TestPageModel({@required this.section})
      : _isLoading = false,
        _index = 0,
        _answerIndex = 0,
        _corrects = 0,
        _answers = [];

  final Section section;

  bool _isLoading;

  /// 現在の問題番号
  int _index;

  /// 正解のindex
  int _answerIndex;

  /// 正解数
  int _corrects;

  /// 選択
  final List<bool> _answers;

  /// 現在の問題
  Phrase get currentPhrase => section.phrases[_index];

  // テストを終了する
  Future _finishTest(BuildContext context) async {
    final un = context.read<UserNotifier>();

    try {
      _isLoading = true;
      notifyListeners();

      await sendEvent(event: AnalyticsEvent.finishTest);

      // send score
      await un.sendTestScore(sectionId: section.id, score: _corrects);
      // get points
      await un.callGetPoint(points: _corrects);

      final challengeAchieved = await un.checkTestStreaks();

      final stats = TestStats(
        challengeAchieved: challengeAchieved,
        section: section,
        questions: 7,
        corrects: _corrects,
        answers: _answers,
      );

      // pop TestPage
      Navigator.of(context).pop();

      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TestResultPage(stats: stats)),
      );
    } on Exception catch (e) {
      InAppLogger.error(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 次の問題へ
  // TODO: refactoring
  Future _next(BuildContext context, int answer) async {
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
      await _finishTest(context);
    } else {
      // seek index
      _index++;
      notifyListeners();
    }
  }

  void _showConfirmDialog(BuildContext context) {
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

  List<String> _randomSelections(BuildContext context) {
    final notifier = Provider.of<LessonNotifier>(context);
    final selections =
        notifier.phrases.sample(4).map((phrase) => phrase.title['en']).toList();
    _answerIndex = Random().nextInt(4);
    selections[_answerIndex] = currentPhrase.title['en'];
    return selections;
  }
}

class TestPage extends StatelessWidget {
  const TestPage({@required this.section});

  // 出題セクション
  final Section section;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TestPageModel(section: section),
      child: _TestPage(),
    );
  }
}

class _TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TestPageModel>();
    final primaryColor = Theme.of(context).primaryColor;
    final selection = state._randomSelections(context);

    return LoadingView(
      loading: state._isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(I.of(context).question(state._index + 1)),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => state._showConfirmDialog(context),
            )
          ],
        ),
        body: TestChoices(
          index: state._index,
          phrase: state.currentPhrase,
          selection: selection,
          onNext: (answer) => state._next(context, answer),
        ),
      ),
    );
  }
}
