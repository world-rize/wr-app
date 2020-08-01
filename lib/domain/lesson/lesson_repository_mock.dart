// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/assets.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/logger.dart';

class LessonMockRepository implements ILessonRepository {
  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    return List<Lesson>.generate(
      6,
      (i) => Lesson(
        id: 'Lesson$i',
        title: {
          'ja': 'Lesson$i',
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
    InAppLogger.log(text);
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
