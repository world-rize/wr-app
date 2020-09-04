// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_result.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class TestResult {
  TestResult({
    @required this.sectionId,
    @required this.score,
    @required this.date,
  }) : assert(score >= 0);

  /// section id
  String sectionId;

  /// test score
  int score;

  /// iso date
  String date;

  factory TestResult.fromJson(Map<String, dynamic> json) =>
      _$TestResultFromJson(json);

  Map<String, dynamic> toJson() => _$TestResultToJson(this);
}
