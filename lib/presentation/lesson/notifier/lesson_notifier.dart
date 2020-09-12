// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/lesson_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

enum Visibility {
  all,
  // 英語
  englishOnly,
  // 日本語
  japaneseOnly,
}

class LessonNotifier with ChangeNotifier {
  LessonService _lessonService;
  UserService _userService;

  List<Lesson> _lessons = [];

  /// singleton
  static LessonNotifier _cache;

  factory LessonNotifier({
    @required LessonService lessonService,
    @required UserService userService,
  }) {
    return _cache ??= LessonNotifier._internal(
        userService: userService, lessonService: lessonService);
  }

  LessonNotifier._internal({
    @required LessonService lessonService,
    @required UserService userService,
  })  : _lessonService = lessonService,
        _userService = userService {
    loadAllLessons();
  }

  Future<void> loadAllLessons() async {
    _lessons = await _lessonService.loadPhrases();
    InAppLogger.info(
        '📚 ${_lessons.length} Lessons, ${phrases.length} Phrases loaded');
  }

  List<Lesson> get lessons => _lessons;

  List<Phrase> phrasesWhere(bool Function(Phrase) filter) {
    return _lessons.expand((lesson) => lesson.phrases).where(filter).toList();
  }

  List<Phrase> get phrases => phrasesWhere((_) => true);

  List<Section> getSectionsById(String id) {
    return _lessonService.getSectionsById(lessons: _lessons, id: id);
  }

  Future<List<Phrase>> favoritePhrases(User user) async {
    return user.favorites.values
        .expand((element) => element.phrases
        .where((element) => false);

    return phrasesWhere((p) => favoritedPhraseIds.contains(p.id));
  }

  Future<List<Phrase>> newComingPhrases() async {
    return _lessonService.newComingPhrases();
  }

  Future<void> sendPhraseRequest({@required String text}) {
    return _lessonService
        .sendPhraseRequest(text: text)
        .catchError(NotifyToast.error);
  }

  bool getShowTranslation() => _lessonService.getShowTranslation();

  void toggleShowTranslation() {
    _lessonService.toggleShowTranslation();
    notifyListeners();
  }

  void toggleShowText() {
    _lessonService.toggleShowText();
    notifyListeners();
  }
}
