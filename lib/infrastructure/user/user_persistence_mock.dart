// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/phrase_list.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/infrastructure/auth/auth_persistence_mock.dart';

class UserPersistenceMock implements UserRepository {
  /// get current user
  User _readUserMock() {
    final notifier = UserNotifier(
      service: UserService(
        authPersistence: AuthPersistenceMock(),
        userPersistence: UserPersistenceMock(),
      ),
    );
    return notifier.getUser();
  }

  @override
  Future<void> test() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User> readUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return User.dummy();
  }

  @override
  Future<User> createUser(CreateUserRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
    return User.dummy();
  }

  @override
  Future<User> updateUser(User req) async {
    await Future.delayed(const Duration(seconds: 1));
    return req;
  }

  @override
  Future<void> deleteUser() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User> favoritePhrase(FavoritePhraseRequest req) async {
    final user = _readUserMock();
    if (req.favorite) {
      user.favorites[req.listId].favoritePhraseIds[req.phraseId] =
          FavoritePhraseDigest(
        id: req.phraseId,
        createdAt: DateTime.now(),
      );
    } else {
      user.favorites[req.listId].favoritePhraseIds.remove(req.phraseId);
    }
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> getPoint(GetPointRequest req) async {
    final user = _readUserMock();
    user.statistics.points += req.points;
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> doTest(DoTestRequest req) async {
    final user = _readUserMock();
    user.statistics.testLimitCount--;
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> sendTestResult(SendTestResultRequest req) async {
    final user = _readUserMock();
    if (user.statistics.testScores[req.sectionId] ?? 0 < req.score) {
      user.statistics.testScores[req.sectionId] = req.score;
    }
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> createFavoriteList(CreateFavoriteListRequest req) async {
    final user = _readUserMock();
    final listId = Uuid().v4();
    user.favorites[listId] = FavoritePhraseList(
      id: listId,
      title: req.name,
      isDefault: false,
      sortType: '',
      favoritePhraseIds: {},
    );
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> deleteFavoriteList(DeleteFavoriteListRequest req) async {
    final user = _readUserMock();
    user.favorites.remove(req.listId);
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> createPhrasesList(CreatePhrasesListRequest req) async {
    final user = _readUserMock();
    final listId = Uuid().v4();
    user.notes[listId] = PhraseList(
      id: listId,
      title: req.title,
      isDefault: false,
      sortType: '',
      phrases: {},
    );
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> addPhraseToPhraseList(AddPhraseToPhraseListRequest req) async {
    final user = _readUserMock();
    if (!user.notes.containsKey(req.listId)) {
      throw Exception('Note ${req.listId} not found');
    }

    user.notes[req.listId].phrases.putIfAbsent(req.phrase.id, () => req.phrase);
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> updatePhrase(UpdatePhraseRequest req) async {
    final user = _readUserMock();
    if (!user.notes.containsKey(req.listId)) {
      throw Exception('Note ${req.listId} not found');
    }

    if (!user.notes[req.listId].phrases.containsKey(req.phraseId)) {
      throw Exception('Phrase ${req.phraseId} not found');
    }

    user.notes[req.listId].phrases[req.phraseId] = req.phrase;

    await Future.delayed(const Duration(seconds: 1));
    return user;
  }
}
