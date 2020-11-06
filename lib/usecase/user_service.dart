// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:collection/collection.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/system/model/user_activity.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/infrastructure/api/functions.dart';

// TODO: Error handling
class UserService {
  const UserService({
    @required UserRepository userPersistence,
    @required IUserAPI userApi,
  })  : _userPersistence = userPersistence,
        _userApi = userApi;

  final UserRepository _userPersistence;
  final UserAPI _userApi;

  /// ユーザーデータを習得します
  Future<User> readUser({
    @required String uuid,
  }) async {
    return _userPersistence.readUser(uuid: uuid);
  }

  /// フレーズをお気に入りに登録します
  Future<User> favorite({
    @required User user,
    @required String listId,
    @required String phraseId,
    @required bool favorite,
  }) async {
    final list = user.favorites[listId];

    if (!user.favorites.containsKey(listId)) {
      throw Exception('favorite list $listId not found');
    }

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

    return _userPersistence.updateFavoriteList(user: user, list: list);
  }

  /// 受講可能回数をリセット
  Future<User> resetTestCount({
    @required User user,
  }) async {
    user.statistics.testLimitCount = 3;
    return _userPersistence.updateUser(user: user);
  }

  /// ポイントを習得します
  Future<User> getPoints({
    @required String uuid,
    @required int points,
  }) async {
    return _userApi.getPoint(uuid: uuid, points: points);
  }

  /// upgrade to Pro or downgrade
  Future<User> changePlan({
    @required User user,
    @required Membership membership,
  }) {
    user.attributes.membership = membership;
    return _userPersistence.updateUser(user: user);
  }

  /// do test
  Future<User> doTest({
    @required User user,
    @required String sectionId,
  }) {
    if (user.statistics.testLimitCount == 0) {
      throw Exception('daily test limit exceeded');
    }

    user.statistics.testLimitCount -= 1;
    user.activities.add(UserActivity(
      content: '$sectionId のテストを受ける',
      date: DateTime.now(),
    ));

    return _userPersistence.updateUser(user: user);
  }

  /// send result
  Future<User> sendTestResult({
    @required User user,
    @required String sectionId,
    @required int score,
  }) {
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

    return _userPersistence.updateUser(user: user);
  }

  /// update user
  Future<User> updateUser({@required User user}) {
    return _userPersistence.updateUser(user: user);
  }

  /// create favorite list
  Future<User> createFavoriteList({
    @required User user,
    @required String title,
  }) {
    return _userPersistence.createFavoriteList(user: user, title: title);
  }

  /// delete favorite list
  Future<User> deleteFavoriteList({
    @required User user,
    @required String listId,
  }) async {
    return _userPersistence.deleteFavoriteList(user: user, listId: listId);
  }

  /// search user from User ID
  Future<User> searchUserFromUserId({@required String userId}) {
    return _userApi.findUserByUserId(uuid: userId);
  }

  /// check test streaks
  Future<bool> checkTestStreaks({@required User user}) async {
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

  /// 友達紹介をする
  Future<void> introduceFriend({
    @required String introduceeUserId,
  }) {
    return _userApi.introduceFriend(introduceeUserId: introduceeUserId);
  }
}
