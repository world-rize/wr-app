// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/extensions.dart';

enum AnswerResult {
  correct,
  incorrect,
}

/// システム情報など
class TestPageNotifier with ChangeNotifier {
  TestPageNotifier({
    @required this.section,
    @required this.userService,
  });

  final UserService userService;

  /// くるくるをみせるか
  bool isLoading = false;

  /// 出題されるセクション
  final Section section;

  /// 現在の問題番号
  int index = 0;

  /// 正解のindex
  int answerIndex = 0;

  /// 正解数
  int corrects = 0;

  /// 選択
  List<bool> answers = <bool>[];

  /// stats
  TestStats stats;

  void showAnswerResultImage(BuildContext context, AnswerResult result) {
    switch (result) {
      case AnswerResult.correct:
        _showTransparentDialog(context,
            'https://4.bp.blogspot.com/-CUR5NlGuXkU/UsZuCrI78dI/AAAAAAAAc20/mMqQPb9bBI0/s800/mark_maru.png');
        break;
      case AnswerResult.incorrect:
        _showTransparentDialog(context,
            'https://1.bp.blogspot.com/-eJGNGE4u8LA/UsZuCAMuehI/AAAAAAAAc2c/QQ5eBSC2Ey0/s800/mark_batsu.png');
        break;
    }
  }

  void _showTransparentDialog(BuildContext context, String path) {
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

  // テストを終了する
  Future finishTest() async {
    try {
      isLoading = true;
      notifyListeners();

      await sendEvent(event: AnalyticsEvent.finishTest);

      // 理想: final user = GlobalStore.currentUser;
      final user = await userService.fetchUser(uid: userService.getUid());
      // send score
      await userService.sendTestResult(
        user: user,
        sectionId: section.id,
        score: corrects,
      );
      // get points
      await userService.getPoints(user: user, points: corrects);

      stats = TestStats(
        challengeAchieved: await userService.checkTestStreaks(user: user),
        section: section,
        questions: 7,
        corrects: corrects,
        answers: answers,
      );
    } on Exception catch (e) {
      InAppLogger.error(e);
    } finally {
//      setState(() {
//        _isLoading = false;
//      });
    }
  }

  /// 選択肢を設定する
  List<String> randomSelections(BuildContext context) {
    final notifier = Provider.of<LessonNotifier>(context);
    final selections =
        notifier.phrases.sample(4).map((phrase) => phrase.title['en']).toList();
    answerIndex = Random().nextInt(4);
    selections[answerIndex] = section.phrases[index].title['en'];
    return selections;
  }

  /// 次の問題へ
  Future<void> next(BuildContext context, int answer) async {
    answers.add(answer == answerIndex);

    // show result
    if (answer == answerIndex) {
      corrects += 1;
      showAnswerResultImage(context, AnswerResult.correct);
    } else {
      showAnswerResultImage(context, AnswerResult.incorrect);
    }
    // seek index
    index++;
    notifyListeners();
  }
}
