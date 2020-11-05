// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:quiver/iterables.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/extensions.dart';

/// セクション: フレーズの集まり
class Section {
  Section({
    @required this.id,
    @required this.title,
    @required this.phrases,
  });

  factory Section.fromPhrase(Phrase phrase) {
    return Section(
      id: phrase.id,
      title: phrase.id,
      phrases: [phrase],
    );
  }

  static List<Section> fromLesson(Lesson lesson) {
    // フレーズを7個ごとに分ける
    return partition(lesson.phrases, 7).toList().indexedMap((i, phrases) {
      return Section(
        id: '${lesson.id}-${i + 1}',
        title: '#${i + 1} ${lesson.id}',
        phrases: phrases,
      );
    }).toList();
  }

  final String id;

  final String title;

  /// list of phrase
  final List<Phrase> phrases;
}
