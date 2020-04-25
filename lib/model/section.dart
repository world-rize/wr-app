// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

/// セクション: フレーズの集まり
@JsonSerializable()
class Section {
  Section({
    @required this.lessonTitle,
    @required this.sectionTitle,
    @required this.phrases,
  });

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  /// title of Lesson
  final String lessonTitle;

  /// title of Section
  final String sectionTitle;

  /// list of phrase
  final List<Phrase> phrases;
}
