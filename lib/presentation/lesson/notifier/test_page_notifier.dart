// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

enum AnswerResult {
  correct,
  incorrect,
}

/// システム情報など
class TestPageNotifier with ChangeNotifier {
  TestPageNotifier({
    @required this.choiceSources,
    @required this.section,
    @required this.userService,
  }) {
    createRandomSelections();
  }

  final UserService userService;

  // 選択肢数
  final choiceLength = 4;

  final List<Phrase> choiceSources;

  // 現在の選択肢
  final List<String> choices = [];

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

  // テストを終了する
  Future<int> finishTest() async {
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

      stats = TestStats(
        challengeAchieved: await userService.checkTestStreaks(user: user),
        section: section,
        questions: section.phrases.length,
        corrects: corrects,
        answers: answers,
      );

      // 一時的
      return stats.corrects;
    } on Exception catch (e) {
      InAppLogger.error(e);
      rethrow;
    }
  }

  /// 選択肢を作成する
  void createRandomSelections() {
    final _choices = choiceSources
        .sample(choiceLength)
        .map((phrase) => phrase.title['en'])
        .toList();
    _choices[answerIndex] = section.phrases[index].title['en'];
    choices
      ..clear()
      ..addAll(_choices);
  }

  Future checkAnswer(int answer) async {
    answers.add(answer == answerIndex);

    if (answer == answerIndex) {
      corrects += 1;
    }
  }

  /// 次の問題へ
  void next() {
    // seek index
    index++;

    if (index > 6) {
      return;
    }

    // 選択肢を作成
    answerIndex = Random().nextInt(choiceLength);
    createRandomSelections();

    notifyListeners();
  }
}
