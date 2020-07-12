// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/lesson_service.dart';
import 'package:wr_app/domain/user/user_service.dart';
import 'package:wr_app/util/logger.dart';

class LessonNotifier with ChangeNotifier {
  LessonService _lessonService;
  UserService _userService;

  List<Lesson> _lessons;

  /// singleton
  static LessonNotifier _cache;

  factory LessonNotifier({
    @required LessonService lessonService,
    @required UserService userService,
  }) {
    return _cache ??= LessonNotifier._internal(lessonService: lessonService);
  }

  LessonNotifier._internal({
    @required LessonService lessonService,
    @required UserService userService,
  }) {
    _lessonService = lessonService;
    _userService = userService;
    InAppLogger.log('[ArticleStore] init');
  }

  Future<void> loadAllLessons() async {
    _lessons = await _lessonService.loadPhrases();
  }

  List<Lesson> get lessons => _lessons;

  List<Phrase> phrasesWhere(bool Function(Phrase) filter) {
    return _lessons.expand((lesson) => lesson.phrases).where(filter);
  }

  List<Phrase> get phrases => phrasesWhere((_) => true);

  List<Section> getSectionsById(String id) {
    return _lessonService.getSectionsById(lessons: _lessons, id: id);
  }

  Future<List<Phrase>> favoritePhrases() async {
    final _user = await _userService.getUser();
    return phrasesWhere(_user.isFavoritePhrase);
  }

  Future<List<Phrase>> newComingPhrases() async {
    // TODO
    return phrasesWhere((p) => p.id.endsWith('5'));
  }

  Future<void> sendPhraseRequest({@required String text}) {
    return _lessonService.sendPhraseRequest(text: text);
  }
}
