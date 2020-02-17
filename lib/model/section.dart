// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase.dart';

class Section {
  Section({
    @required this.lessonTitle,
    @required this.sectionTitle,
    @required this.phrases,
  });

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

  Map<String, dynamic> toJson() {
    return {
      'lessonTitle': lessonTitle,
      'sectionTitle': sectionTitle,
      'phrases': phrases.map((p) => p.toJson()),
    };
  }
}

class Lesson {
  Lesson(this.title, this.thumbnailUrl);

  String title;
  String thumbnailUrl;
}
