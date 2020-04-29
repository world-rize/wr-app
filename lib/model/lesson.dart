// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:wr_app/model/example.dart';
import 'package:wr_app/model/assets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

/// レッスン
@JsonSerializable()
class Lesson {
  Lesson({this.id, this.title, this.assets});

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  String id;

  /// タイトル
  Map<String, String> title;

  /// assets
  Assets assets;
}
