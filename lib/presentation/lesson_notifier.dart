// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/lesson_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

class LessonNotifier with ChangeNotifier {
  factory LessonNotifier({
    @required LessonService lessonService,
  }) {
    return _cache ??= LessonNotifier._internal(
      lessonService: lessonService,
    );
  }

  LessonNotifier._internal({
    @required LessonService lessonService,
  }) : _lessonService = lessonService {
    loadAllLessons();
  }

  User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    favorites = _lessonService.getAllFavoriteLists(userUuid: user.uuid);
    notifyListeners();
  }

  LessonService _lessonService;

  List<Lesson> _lessons = [];
  Future<List<FavoritePhraseList>> favorites;

  /// singleton
  static LessonNotifier _cache;

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

  Future<List<Phrase>> getFavoritePhrases(User user) async {
    final favoriteIds =
        (await favorites).expand((list) => list.phrases).map((p) => p.id);
    return phrasesWhere((p) => favoriteIds.contains(p.id));
  }

  /// フレーズをお気に入りに登録します
  Future<void> favoritePhrase({
    @required User user,
    @required String phraseId,
    @required bool favorite,
  }) async {
    // TODO: default以外に保存できるようにする
    // defaultふぁぼりてリスト以外に保存したらdeleteするときむずかしくね?
    var defaultFavoriteList =
        (await favorites).firstWhere((element) => element.id == 'default');

    // false -> true
    defaultFavoriteList = await _lessonService.favorite(
      user: user,
      listId: defaultFavoriteList.id,
      phraseId: phraseId,
      favorite: favorite,
    );

    // 連打されると困るのでお気に入り登録するときだけdelay
    if (favorite) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    notifyListeners();

    InAppLogger.debug(favorite ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
  }

  /// exist phrase in favorites
  Future<bool> existPhraseInFavoriteList({
    @required User user,
    @required String phraseId,
  }) async {
    return (await getFavoritePhrases(user)).any((p) => p.id == phraseId);
  }
}
