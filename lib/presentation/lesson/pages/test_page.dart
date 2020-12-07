// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/presentation/lesson/widgets/test_choices.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

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

enum AnswerResult {
  correct,
  incorrect,
}

/// [TestPage] の State
class TestPageState extends State<TestPage> {
  TestPageState({@required this.section});

  bool _isLoading;

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
    _isLoading = false;
    _index = 0;
    _answers = [];
  }

  void _playOneshot(String path) {
    final player = AssetsAudioPlayer();
    final audio = Audio(path);
    player.open(audio, autoStart: true);
  }

  void _showTransparentDialog(String path) {
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
            child: Image.network(path),
          ),
        ),
      ),
    );
  }

  // TODO: refactoring
  void playAnswerResultSe(AnswerResult result) {
    switch (result) {
      case AnswerResult.correct:
        _playOneshot('assets/se/correct.mp3');
        break;
      case AnswerResult.incorrect:
        _playOneshot('assets/se/incorrect.mp3');
        break;
    }
  }

  void showAnswerResultImage(AnswerResult result) {
    switch (result) {
      case AnswerResult.correct:
        _showTransparentDialog(
            'https://4.bp.blogspot.com/-CUR5NlGuXkU/UsZuCrI78dI/AAAAAAAAc20/mMqQPb9bBI0/s800/mark_maru.png');
        break;
      case AnswerResult.incorrect:
        _showTransparentDialog(
            'https://1.bp.blogspot.com/-eJGNGE4u8LA/UsZuCAMuehI/AAAAAAAAc2c/QQ5eBSC2Ey0/s800/mark_batsu.png');
        break;
    }
  }

  // テストを終了する
  Future _finishTest() async {
    final un = context.read<UserNotifier>();

    try {
      setState(() {
        _isLoading = true;
      });

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
//      setState(() {
//        _isLoading = false;
//      });
    }
  }

  /// 次の問題へ
  // TODO: refactoring
  Future<void> _next(int answer) async {
    _answers.add(answer == _answerIndex);

    // show result
    if (answer == _answerIndex) {
      _corrects += 1;
      showAnswerResultImage(AnswerResult.correct);
      playAnswerResultSe(AnswerResult.correct);
    } else {
      showAnswerResultImage(AnswerResult.incorrect);
      playAnswerResultSe(AnswerResult.incorrect);
    }

    // test finish
    if (_index == section.phrases.length - 1) {
      await _finishTest();
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

    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingView(
        loading: _isLoading,
        child: Scaffold(
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
        ),
      ),
    );
  }
}
