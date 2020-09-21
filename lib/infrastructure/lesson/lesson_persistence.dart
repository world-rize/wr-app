// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/cloud_functions.dart';
import 'package:wr_app/util/logger.dart';

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

class LessonPersistence implements LessonRepository {
  String SHOW_JAPANESE = 'show_japanese';
  String SHOW_ENGLISH = 'show_english';

  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    const lessonsJsonPath = 'assets/lessons.json';
    const phrasesJsonPath = 'assets/phrases.json';
    InAppLogger.info('\t Lessons Json @ $lessonsJsonPath');
    InAppLogger.info('\t Phrases Json @ $phrasesJsonPath');

    final lessons = await loadAllLessonsFromLocal(
      lessonsJsonPath: lessonsJsonPath,
      phrasesJsonPath: phrasesJsonPath,
    );

    // inspect
    lessons.forEach((lesson) {
      InAppLogger.debug(
          '\t ${lesson.id}: ${lesson.phrases.length} phrases found');
    });

    return lessons;
  }

  @override
  Future<void> sendPhraseRequest({
    @required String email,
    @required String text,
  }) {
    print('text $text');
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
  bool getShowJapanese() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool(SHOW_JAPANESE) ?? false;
  }

  @override
  void setShowEnglish({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool(SHOW_ENGLISH, value);
  }

  @override
  bool getShowEnglish() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool(SHOW_ENGLISH) ?? true;
  }

  @override
  void setShowJapanese({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool(SHOW_JAPANESE, value);
  }

  @override
  Future<List<Phrase>> newComingPhrases() async {
    // work around
    // Map<dynamic, dynamic> -> Map<String, dynamic>
    Map<String, dynamic> fromDynamic(dynamic mapLike) {
      final entries = Map.from(mapLike)
          .entries
          .map((e) => MapEntry(e.key.toString(), e.value));
      return Map<String, dynamic>.fromEntries(entries);
    }

    return callFunction('getNewComingPhrases').then((res) =>
        jsonDecode(jsonEncode(res.data))
            .map<Phrase>((p) => Phrase.fromJson(fromDynamic(p)))
            .toList());
  }
}
