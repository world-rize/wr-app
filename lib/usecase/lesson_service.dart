// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/lesson/i_favorite_repository.dart';
import 'package:wr_app/infrastructure/lesson/i_lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/util/logger.dart';

class LessonService {
  const LessonService({
    @required ILessonRepository lessonRepository,
    @required IFavoriteRepository favoriteRepository,
  })  : _lessonRepository = lessonRepository,
        _favoriteRepository = favoriteRepository;

  final ILessonRepository _lessonRepository;
  final IFavoriteRepository _favoriteRepository;

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
    final env = DotEnv().env;
    final email = env['REQUEST_MAIL_ADDRESS'];
    assert(email != '');
    await _lessonRepository.sendPhraseRequest(email: email, text: text);

    InAppLogger.info('send phrase request');
  }

  bool getShowJapanese() => _lessonRepository.getShowJapanese();

  bool getShowEnglish() => _lessonRepository.getShowEnglish();

  void toggleShowJapanese() {
    final value = _lessonRepository.getShowJapanese();
    _lessonRepository.setShowJapanese(value: !value);
  }

  void toggleShowEnglish() {
    final value = _lessonRepository.getShowEnglish();
    _lessonRepository.setShowEnglish(value: !value);
  }

  Future<List<Phrase>> newComingPhrases() {
    return _lessonRepository.newComingPhrases();
  }

  Future<FavoritePhraseList> findFavoriteListById({
    @required String userUuid,
    @required String listUuid,
  }) {
    return _favoriteRepository.findById(userUuid: userUuid, listUuid: listUuid);
  }

  Future<List<FavoritePhraseList>> getAllFavoriteLists(
      {@required String userUuid}) {
    return _favoriteRepository.getAllFavoriteLists(userUuid: userUuid);
  }

  /// create favorite list
  Future<FavoritePhraseList> createFavoriteList({
    @required User user,
    @required String title,
    @required bool isDefault,
  }) {
    return _favoriteRepository.createFavoriteList(
        userUuid: user.uuid, title: title, isDefault: isDefault);
  }

  /// delete favorite list
  Future<FavoritePhraseList> deleteFavoriteList({
    @required User user,
    @required String listId,
  }) async {
    return _favoriteRepository.deleteFavoriteList(
        userUuid: user.uuid, listUuid: listId);
  }

  /// フレーズをお気に入り登録のtoggle
  Future<FavoritePhraseList> favorite({
    @required User user,
    @required String listId,
    @required String phraseId,
    @required bool favorite,
  }) async {
    final list = await _favoriteRepository.findById(
      userUuid: user.uuid,
      listUuid: listId,
    );
    // FIXME: 見つからなかったときthrowする
    // どのようなエラーが発生するかわからない
    // throw Exception('favorite list $listId not found');

    final index = list.phrases.indexWhere((p) => p.id == phraseId);
    if (favorite) {
      if (index == -1) {
        list.phrases
            .add(FavoritePhraseDigest(id: phraseId, createdAt: DateTime.now()));
      } else {
        list.phrases[index] =
            FavoritePhraseDigest(id: phraseId, createdAt: DateTime.now());
      }
    } else {
      list.phrases.removeAt(index);
    }

    return _favoriteRepository.updateFavoriteList(
        userUuid: user.uuid, list: list);
  }
}
