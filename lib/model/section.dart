// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase.dart';

/// セクション: フレーズの集まり
class Section {
  Section({
    @required this.lessonTitle,
    @required this.sectionTitle,
    @required this.phrases,
  });

  /// json to [Section]
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      lessonTitle: json['lessonTitle'],
      sectionTitle: json['sectionTitle'],
      phrases: json['phrases'].map<Phrase>((p) => Phrase.fromJson(p)).toList(),
    );
  }

  /// title of Lesson
  final String lessonTitle;

  /// title of Section
  final String sectionTitle;

  /// list of phrase
  final List<Phrase> phrases;

  /// [Section] to json
  Map<String, dynamic> toJson() {
    return {
      'lessonTitle': lessonTitle,
      'sectionTitle': sectionTitle,
      'phrases': phrases.map((p) => p.toJson()),
    };
  }
}
