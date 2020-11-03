// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/util/logger.dart';

class LessonService {
  final LessonRepository _lessonPersistence;

  const LessonService({
    required LessonRepository lessonPersistence,
  }) : _lessonPersistence = lessonPersistence;

  Future<List<Lesson>> loadPhrases() {
    return _lessonPersistence.loadAllLessons();
  }

  List<Section> getSectionsById({
    required List<Lesson> lessons,
    required String id,
  }) {
    final lesson = lessons.firstWhere((lesson) => lesson.id == id);
    return Section.fromLesson(lesson);
  }

  Future<void> sendPhraseRequest({
    required String text,
  }) async {
    final env = DotEnv().env;
    final email = env['REQUEST_MAIL_ADDRESS']!;
    assert(email != '');
    await _lessonPersistence.sendPhraseRequest(email: email, text: text);

    InAppLogger.info('send phrase request');
  }

  bool getShowJapanese() => _lessonPersistence.getShowJapanese();
  bool getShowEnglish() => _lessonPersistence.getShowEnglish();

  void toggleShowJapanese() {
    final value = _lessonPersistence.getShowJapanese();
    _lessonPersistence.setShowJapanese(value: !value);
  }

  void toggleShowEnglish() {
    final value = _lessonPersistence.getShowEnglish();
    _lessonPersistence.setShowEnglish(value: !value);
  }

  Future<List<Phrase>> newComingPhrases() {
    return _lessonPersistence.newComingPhrases();
  }
}
