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
    @required LessonRepository lessonPersistence,
  }) : _lessonPersistence = lessonPersistence;

  Future<List<Lesson>> loadPhrases() {
    return _lessonPersistence.loadAllLessons();
  }

  List<Section> getSectionsById({
    @required List<Lesson> lessons,
    @required String id,
  }) {
    final lesson = lessons.firstWhere((lesson) => lesson.id == id);
    return Section.fromLesson(lesson);
  }

  Future<void> sendPhraseRequest({
    @required String text,
  }) async {
    final email = DotEnv().env['FEEDBACK_MAIL_ADDRESS'];
    await _lessonPersistence.sendPhraseRequest(email: email, text: text);

    InAppLogger.info('send phrase request');
  }

  bool getShowTranslation() => _lessonPersistence.getShowTranslation();

  void toggleShowTranslation() {
    final value = _lessonPersistence.getShowTranslation();
    _lessonPersistence.setShowTranslation(value: !value);
  }

  bool getShowText() => _lessonPersistence.getShowText();

  void toggleShowText() {
    final value = _lessonPersistence.getShowText();
    _lessonPersistence.setShowText(value: !value);
  }

  Future<List<Phrase>> newComingPhrases() {
    return _lessonPersistence.newComingPhrases();
  }
}
