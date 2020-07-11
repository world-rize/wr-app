// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';

class LessonService {
  final LessonRepository _lessonRepository;

  const LessonService({
    @required LessonRepository lessonRepository,
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
}
