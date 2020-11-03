// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';

/// セクション: フレーズの集まり
class Section {
  Section({
    required this.id,
    required this.title,
    required this.phrases,
  });

  factory Section.fromPhrase(Phrase phrase) {
    return Section(
      id: phrase.id,
      title: phrase.id,
      phrases: [phrase],
    );
  }

  static List<Section> fromLesson(Lesson lesson) {
    final sections = <Section>[];
    // フレーズを7個ごとに分ける
    for (var i = 0; i < lesson.phrases.length; i += 7) {
      sections.add(Section(
        id: '${lesson.id}-${i ~/ 7 + 1}',
        title: '#${i ~/ 7 + 1} ${lesson.id}',
        phrases:
            lesson.phrases.sublist(i, min(i + 7, lesson.phrases.length - 1)),
      ));
    }
    return sections;
  }

  final String id;

  final String title;

  /// list of phrase
  final List<Phrase> phrases;
}
