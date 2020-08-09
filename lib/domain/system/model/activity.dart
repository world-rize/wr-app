// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

/// アプリ内の活動(ポイントゲット, テストなど)
@JsonSerializable(explicitToJson: true, anyMap: true)
class UserActivity {
  UserActivity({
    @required this.content,
    @required this.date,
  });

  factory UserActivity.fromJson(Map<String, dynamic> json) =>
      _$UserActivityFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivityToJson(this);

  String content;

  DateTime date;
}
