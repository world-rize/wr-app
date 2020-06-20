// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase/lesson.dart';
import 'package:wr_app/model/phrase/phrase.dart';

/// セクション: フレーズの集まり
class Section {
  Section({
    @required this.title,
    @required this.phrases,
  });

  static List<Section> fromLesson(Lesson lesson) {
    final sections = <Section>[];
    for (var i = 0; i < lesson.phrases.length; i += 7) {
      sections.add(Section(
        title: '${lesson.id} ${i ~/ 7 + 1}',
        phrases:
            lesson.phrases.sublist(i, min(i + 7, lesson.phrases.length - 1)),
      ));
    }
    return sections;
  }

  final String title;

  /// list of phrase
  final List<Phrase> phrases;
}
