// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/index.dart';

/// テストの情報
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
