// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/assets.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';

part 'lesson.g.dart';

/// レッスンを表す
///
/// - レッスンはカテゴリ分けされたフレーズの集まり
///
@JsonSerializable()
class Lesson {
  Lesson({
    @required this.id,
    @required this.title,
    @required this.phrases,
    @required this.assets,
  });

  factory Lesson.fromJson(Map<dynamic, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  /// ID
  String id;

  /// タイトル
  Map<String, String> title;

  /// フレーズ
  List<Phrase> phrases;

  /// assets
  Assets assets;
}
