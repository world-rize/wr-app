// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_attributes.dart';
import 'package:wr_app/domain/user/model/user_statistics.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/cloud_functions.dart';

class TestLimitExceededError implements Exception {
  TestLimitExceededError(this.cause);
  String cause;
}

class NotFoundError implements Exception {
  NotFoundError(this.cause);
  String cause;
}

// TODO: i10n注入
class UserPersistence implements UserRepository {
  const UserPersistence({@required this.store});

  final FirebaseFirestore store;

  CollectionReference get users => store.collection('users');

  Future<User> getUser(String uuid) async {
    final ss = await users.doc(uuid).get();
    if (!ss.exists) {
      throw NotFoundError('uuid $uuid not found');
    }
    return User.fromJson(ss.data());
  }

  Future<User> setUser(User user) async {
    await users.doc(user.uuid).set(user.toJson());
    return user;
  }

  @override
  User generateInitialUser(String uuid) {
    final defaultFavoriteList = generateFavoriteList(
      listId: Uuid().v4(),
      title: 'お気に入り',
      isDefault: true,
    );
    final defaultNote = generateNote(
      noteId: Uuid().v4(),
      title: 'ノート',
      isDefault: true,
    );
    final achievedNote = generateNote(
      noteId: Uuid().v4(),
      title: 'Achieved Note',
      isAchieved: true,
    );

    return User(
      uuid: uuid,
      name: '',
      // TODO
      userId: uuid,
      favorites: {
        defaultFavoriteList.id: defaultFavoriteList,
      },
      notes: {
        defaultNote.id: defaultNote,
        achievedNote.id: achievedNote,
      },
      statistics: UserStatistics(
        testResults: [],
        points: 0,
        testLimitCount: 3,
        lastLogin: DateTime.now().toIso8601String(),
        isIntroducedFriend: false,
      ),
      activities: [],
      attributes: UserAttributes(
        age: '',
        email: '',
        membership: Membership.normal,
      ),
      items: {},
    );
  }

  @override
  FavoritePhraseList generateFavoriteList({
    @required String listId,
    @required String title,
    bool isDefault = false,
  }) {
    return FavoritePhraseList(
      id: listId,
      title: title,
      isDefault: isDefault,
      phrases: [],
      sortType: 'createdAt-',
    );
  }

  @override
  Note generateNote({
    @required String noteId,
    @required String title,
    bool isDefault = false,
    bool isAchieved = false,
  }) {
    return Note(
        id: noteId,
        title: title,
        sortType: 'createdAt-',
        isDefaultNote: isDefault,
        isAchievedNote: isAchieved,
        phrases: isAchieved
            ? []
            : List.generate(30, (index) => NotePhrase.create()));
  }

  @override
  Future introduceFriend({
    @required String uuid,
    @required String introduceeUserId,
  }) {
    return callFunction('introduceFriend', {
      'introduceeUserId': introduceeUserId,
    });
  }

  @override
  Future<User> findUserByUserId({@required String uuid}) async {
    final res = await callFunction('findUserByUserId', {
      'userId': uuid,
    });
    return res.data != null ? User.fromJson(res.data) : null;
  }

  @override
  Future<User> deleteFavoriteList(
      {@required String uuid, @required String listId}) async {
    final user = await getUser(uuid);
    user.favorites.remove(listId);
    return setUser(user);
  }

  @override
  Future<User> createFavoriteList({
    @required String uuid,
    @required String title,
  }) async {
    final user = await getUser(uuid);
    final listId = Uuid().v4();
    user.favorites[listId] = generateFavoriteList(listId: listId, title: title);
    return setUser(user);
  }

  @override
  Future<User> sendTestResult(
      {@required String uuid,
      @required String sectionId,
      @required int score}) async {
    final user = await getUser(uuid);

    // 記録追加
    user.statistics.testResults.add(TestResult(
      sectionId: sectionId,
      score: score,
      date: DateTime.now().toIso8601String(),
    ));

    user.activities.add(UserActivity(
      content: '$sectionId のテストで $score 点を獲得',
      date: DateTime.now(),
    ));

    return setUser(user);
  }

  @override
  Future<bool> checkTestStreaks({@required String uuid}) async {
    final user = await getUser(uuid);
    // 29日前の0時
    final begin = Jiffy().startOf(Units.DAY).subtract(const Duration(days: 29));
    // 過去30日間のstreakを調べる
    final last30daysResults = user.statistics.testResults
        .where((result) => Jiffy(result.date).isAfter(begin));
    final streaked = groupBy(last30daysResults,
            (TestResult result) => Jiffy(result.date).startOf(Units.DAY))
        .values
        .every((results) => results.length >= 3);
    return streaked;
  }

  @override
  Future<User> doTest(
      {@required String uuid, @required String sectionId}) async {
    final user = await getUser(uuid);

    if (user.statistics.testLimitCount == 0) {
      throw TestLimitExceededError('daily test limit exceeded');
    }

    user.statistics.testLimitCount -= 1;
    user.activities.add(UserActivity(
      content: '$sectionId のテストを受ける',
      date: DateTime.now(),
    ));
    return setUser(user);
  }

  @override
  Future<User> getPoint({@required String uuid, @required int points}) {
    return callFunction('getPoint', {
      'points': points,
    }).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> favoritePhrase({
    @required String uuid,
    @required String phraseId,
    @required String listId,
    @required bool favorite,
  }) async {
    final user = await getUser(uuid);
    if (!user.favorites.containsKey(listId)) {
      throw NotFoundError('favorite list $listId not found');
    }

    // TODO: refactoring
    final index =
        user.favorites[listId].phrases.indexWhere((p) => p.id == phraseId);
    if (favorite) {
      if (index == -1) {
        user.favorites[listId].phrases
            .add(FavoritePhraseDigest(id: phraseId, createdAt: DateTime.now()));
      } else {
        user.favorites[listId].phrases[index] =
            FavoritePhraseDigest(id: phraseId, createdAt: DateTime.now());
      }
    } else {
      user.favorites[listId].phrases.removeAt(index);
    }

    return setUser(user);
  }

  @override
  Future deleteUser({
    @required String uuid,
  }) async {
    return users.doc(uuid).delete();
  }

  @override
  Future<User> updateUser({
    @required User user,
  }) {
    return setUser(user);
  }

  @override
  Future<User> createUser({
    @required String name,
    @required String email,
  }) async {
    final user = generateInitialUser(Uuid().v4())
      ..name = name
      ..attributes.email = email;

    return user;
  }

  @override
  Future<User> readUser({
    @required String uuid,
  }) {
    return getUser(uuid);
  }
}
