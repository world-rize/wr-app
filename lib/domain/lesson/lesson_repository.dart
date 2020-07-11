// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/store/logger.dart';

abstract class ILessonRepository {
  Future<List<Lesson>> loadAllLessons();
}

class LessonRepository implements ILessonRepository {
  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    const lessonsJsonPath = 'assets/lessons.json';
    const phrasesJsonPath = 'assets/phrases.json';

    InAppLogger.log('\t Lessons Json @ $lessonsJsonPath');
    InAppLogger.log('\t Phrases Json @ $phrasesJsonPath');

    // load lessons
    final lessons = await rootBundle
        .loadString(lessonsJsonPath)
        .then(jsonDecode)
        .then((json) => List.from(json))
        .then((list) =>
            List.from(list).map((json) => Lesson.fromJson(json)).toList())
        .catchError((e) {
      print(e);
      InAppLogger.log(e.toString());
    });

    // load phrases
    final phrases = await rootBundle
        .loadString(phrasesJsonPath)
        .then(jsonDecode)
        .then((json) => List.from(json))
        .then((list) =>
            List.from(list).map((json) => Phrase.fromJson(json)).toList())
        .catchError((e) {
      print(e);
      InAppLogger.log(e.toString());
    });

    // mapping phrases
    final phraseMap =
        groupBy<Phrase, String>(phrases, (phrase) => phrase.meta['lessonId']);

    lessons.forEach((lesson) {
      if (phraseMap.containsKey(lesson.id)) {
        lesson.phrases = phraseMap[lesson.id];
        InAppLogger.log(
            '\t ${lesson.id}: ${phraseMap[lesson.id].length} phrases found');
      } else {
        InAppLogger.log('\t warn ${lesson.id} not found');
      }
    });

    return lessons;
  }
}
