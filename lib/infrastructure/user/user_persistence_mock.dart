// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/infrastructure/auth/auth_persistence_mock.dart';
import 'package:wr_app/infrastructure/note/note_persistence_mock.dart';
import 'package:wr_app/usecase/note_service.dart';

class UserPersistenceMock implements UserRepository {
  /// get current user
  User _readUserMock() {
    final notifier = UserNotifier(
      userService: UserService(
        authPersistence: AuthPersistenceMock(),
        userPersistence: UserPersistenceMock(),
      ),
      noteService: NoteService(notePersistence: NotePersistenceMock()),
    );
    return notifier.getUser();
  }

  @override
  Future<void> test() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> login() async {
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

    // push test result
    final result = TestResult(
      sectionId: req.sectionId,
      score: req.score,
      date: DateTime.now().toIso8601String(),
    );

    user.statistics.testResults.add(result);

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
  Future<User> findUserByUserId(FindUserByUserIdRequest req) async {
    return User.dummy()..userId = req.userId;
  }

  @override
  Future<bool> checkTestStreaks(CheckTestStreaksRequest req) async {
    return false;
  }
}
