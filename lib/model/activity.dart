// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

/// アプリ内の活動(ポイントゲット, テストなど)
@JsonSerializable()
class Activity {
  Activity({
    @required this.text,
    @required this.uuid,
    @required this.type,
    @required this.date,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  /// uuid
  final String uuid;

  /// date
  final DateTime date;

  /// type
  final String type;

  /// 内容
  final String text;

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
