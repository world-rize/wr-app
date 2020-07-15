// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/logger.dart';

abstract class ILessonRepository {
  Future<List<Lesson>> loadAllLessons();
  Future<void> sendPhraseRequest({String text, String email});

  bool getShowTranslation();
  void setShowTranslation({bool value});

  bool getShowText();
  void setShowText({bool value});
}

/// load all lessons from local
Future<List<Lesson>> loadAllLessonsFromLocal({
  @required String lessonsJsonPath,
  @required String phrasesJsonPath,
}) async {
  // load lessons
  final lessons = await rootBundle
      .loadString(lessonsJsonPath)
      .then(jsonDecode)
      .then((json) => List.from(json))
      .then((list) =>
          List.from(list).map((json) => Lesson.fromJson(json)).toList());

  // load phrases
  final phrases = await rootBundle
      .loadString(phrasesJsonPath)
      .then(jsonDecode)
      .then((json) => List.from(json))
      .then((list) =>
          List.from(list).map((json) => Phrase.fromJson(json)).toList());

  // mapping phrases
  final phraseMap =
      groupBy<Phrase, String>(phrases, (phrase) => phrase.meta['lessonId']);

  lessons.forEach((lesson) {
    if (phraseMap.containsKey(lesson.id)) {
      lesson.phrases = phraseMap[lesson.id];
    }
  });

  return lessons;
}

class LessonRepository implements ILessonRepository {
  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    const lessonsJsonPath = 'assets/lessons.json';
    const phrasesJsonPath = 'assets/phrases.json';

    InAppLogger.log('\t Lessons Json @ $lessonsJsonPath');
    InAppLogger.log('\t Phrases Json @ $phrasesJsonPath');

    final lessons = await loadAllLessonsFromLocal(
      lessonsJsonPath: lessonsJsonPath,
      phrasesJsonPath: phrasesJsonPath,
    );

    // inspect
    lessons.forEach((lesson) {
      InAppLogger.log(
          '\t ${lesson.id}: ${lesson.phrases.length} phrases found');
    });

    return lessons;
  }

  @override
  Future<void> sendPhraseRequest({
    @required String text,
    @required String email,
  }) {
    final request = Email(
      body: text,
      subject: 'WorldRIZe phrase request',
      recipients: [email],
      attachmentPaths: [],
      isHTML: false,
    );

    return FlutterEmailSender.send(request);
  }

  @override
  bool getShowTranslation() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('show_translation') ?? false;
  }

  @override
  void setShowTranslation({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('show_translation', value);
  }

  @override
  bool getShowText() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('show_text') ?? true;
  }

  @override
  void setShowText({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('show_text', value);
  }
}
