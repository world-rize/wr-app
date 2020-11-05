// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/user_repository.dart';

// TODO: Error handling
class UserService {
  const UserService({
    @required UserRepository userPersistence,
  }) : _userPersistence = userPersistence;

  final UserRepository _userPersistence;

  /// ユーザーデータを習得します
  Future<User> readUser({
    @required String uuid,
  }) async {
    return _userPersistence.readUser(uuid: uuid);
  }

  /// フレーズをお気に入りに登録します
  Future<User> favorite({
    @required String uuid,
    @required String listId,
    @required String phraseId,
    @required bool favorite,
  }) async {
    return _userPersistence.favoritePhrase(
      uuid: uuid,
      listId: listId,
      phraseId: phraseId,
      favorite: favorite,
    );
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
    return _userPersistence.getPoint(uuid: uuid, points: points);
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
    @required String uuid,
    @required String sectionId,
  }) {
    return _userPersistence.doTest(
      uuid: uuid,
      sectionId: sectionId,
    );
  }

  /// send result
  Future<User> sendTestResult({
    @required String uuid,
    @required String sectionId,
    @required int score,
  }) {
    return _userPersistence.sendTestResult(
      uuid: uuid,
      sectionId: sectionId,
      score: score,
    );
  }

  /// update user
  Future<User> updateUser({@required User user}) {
    return _userPersistence.updateUser(user: user);
  }

  /// create favorite list
  Future<User> createFavoriteList({
    @required String uuid,
    @required String title,
  }) {
    return _userPersistence.createFavoriteList(uuid: uuid, title: title);
  }

  /// delete favorite list
  Future<User> deleteFavoriteList({
    @required String uuid,
    @required String listId,
  }) async {
    return _userPersistence.deleteFavoriteList(uuid: uuid, listId: listId);
  }

  /// search user from User ID
  Future<User> searchUserFromUserId({@required String userId}) {
    return _userPersistence.findUserByUserId(uuid: userId);
  }

  /// check test streaks
  Future<bool> checkTestStreaks({@required String uuid}) {
    return _userPersistence.checkTestStreaks(uuid: uuid);
  }

  /// 友達紹介をする
  Future<void> introduceFriend({
    @required String uuid,
    @required String introduceeUserId,
  }) {
    return _userPersistence.introduceFriend(
        uuid: uuid, introduceeUserId: introduceeUserId);
  }
}
