// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/lesson/i_lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/assets.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/logger.dart';

class LessonPersistenceMock implements ILessonRepository {
  String SHOW_JAPANESE = 'show_japanese';
  String SHOW_ENGLISH = 'show_english';

  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    return List<Lesson>.generate(
      6,
      (i) => Lesson(
        id: 'Lesson$i',
        title: {
          'ja': 'レッスン$i',
          'en': 'Lesson$i',
        },
        phrases: List.generate(100, (index) => Phrase.dummy(index)),
        assets: Assets(
          img: {
            'thumbnail': 'assets/thumbnails/business.png',
          },
        ),
      ),
    );
  }

  @override
  Future<void> sendPhraseRequest({String text, String email}) async {
    InAppLogger.info(text);
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
    return <Phrase>[];
  }
}
