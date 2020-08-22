// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_statistics.g.dart';

/// 統計情報
@JsonSerializable(explicitToJson: true, anyMap: true)
class UserStatistics {
  UserStatistics({
    @required this.testScores,
    @required this.points,
    @required this.testLimitCount,
    @required this.lastLogin,
  });

  factory UserStatistics.dummy() {
    return UserStatistics(
      testScores: {
        'debug': 5,
      },
      points: 100,
      testLimitCount: 3,
      lastLogin: '',
    );
  }

  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatisticsToJson(this);

  Map<String, int> testScores;

  int points;

  int testLimitCount;

  String lastLogin;
}
