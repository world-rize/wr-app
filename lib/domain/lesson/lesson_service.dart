// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

class LessonService {
  final ILessonRepository _lessonRepository;

  const LessonService({
    @required ILessonRepository lessonRepository,
  }) : _lessonRepository = lessonRepository;

  Future<List<Lesson>> loadPhrases() {
    return _lessonRepository.loadAllLessons();
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
    await _lessonRepository
        .sendPhraseRequest(email: email, text: text)
        .catchError(NotifyToast.error);

    InAppLogger.log('send phrase request', type: 'api');
  }

  bool getShowTranslation() => _lessonRepository.getShowTranslation();

  void toggleShowTranslation() {
    final value = _lessonRepository.getShowTranslation();
    _lessonRepository.setShowTranslation(value: !value);
  }

  bool getShowText() => _lessonRepository.getShowText();

  void toggleShowText() {
    final value = _lessonRepository.getShowText();
    _lessonRepository.setShowText(value: !value);
  }
}
