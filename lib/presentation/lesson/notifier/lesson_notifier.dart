// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/lesson_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

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
    InAppLogger.info('📚 ${_lessons.length} Lessons loaded');
  }

  List<Lesson> getAllLessons() {
    return _lessons;
  }

  // TODO: usecaseに移動
  List<Lesson> getLessons(User user) {
    if (user.isPremium) {
      return _lessons;
    } else {
      return _lessons.sublist(0, 3);
    }
  }

  bool isLessonLocked(User user, Lesson lesson) {
    if (user.isPremium) {
      return false;
    } else {
      return 3 <= _lessons.indexOf(lesson);
    }
  }

  List<Phrase> phrasesWhere(bool Function(Phrase) filter) {
    return _lessons.expand((lesson) => lesson.phrases).where(filter).toList();
  }

  List<Phrase> getPhrases(User user) {
    if (user.isPremium) {
      return _lessons.sublist(0, 3).expand((lesson) => lesson.phrases).toList();
    } else {
      return _lessons.expand((lesson) => lesson.phrases).toList();
    }
  }

  List<Phrase> get phrases => phrasesWhere((_) => true);

  List<Section> getSectionsById(String id) {
    return _lessonService.getSectionsById(lessons: _lessons, id: id);
  }

  Future<List<Phrase>> favoritePhrases(User user) async {
    final favoriteIds =
        user.favorites.values.expand((list) => list.phrases).map((p) => p.id);
    return phrasesWhere((p) => favoriteIds.contains(p.id));
  }

  Future<List<Phrase>> newComingPhrases() async {
    return _lessonService.newComingPhrases();
  }

  Future<void> sendPhraseRequest({@required String text}) {
    return _lessonService
        .sendPhraseRequest(text: text)
        .catchError(NotifyToast.error);
  }

  bool get showJapanese => _lessonService.getShowJapanese();
  bool get showEnglish => _lessonService.getShowEnglish();

  void toggleJapanese() {
    _lessonService.toggleShowJapanese();
    notifyListeners();
  }

  void toggleEnglish() {
    _lessonService.toggleShowEnglish();
    notifyListeners();
  }
}
