// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/index.dart';

/// テストの情報
class TestStats {
  TestStats({
    required this.section,
    required this.answers,
    required this.challengeAchieved,
    required this.corrects,
    this.questions = 7,
  });

  Section section;
  int questions;
  int corrects;
  List<bool> answers;
  bool challengeAchieved;
}
