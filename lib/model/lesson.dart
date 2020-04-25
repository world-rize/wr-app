// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

/// レッスン: セクションの集まり
@JsonSerializable()
class Lesson {
  Lesson(this.title, this.thumbnailUrl);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  /// レッスン名: 学校, 日常など
  String title;

  /// レッスントップ画面に表示される画像URL
  String thumbnailUrl;
}
