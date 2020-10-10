// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/logger.dart';

// TODO: Error handling
/// singleton
class UserService {
  factory UserService({
    @required UserRepository userPersistence,
  }) {
    return _cache ??= UserService._(userPersistence: userPersistence);
  }

  UserService._({
    @required UserRepository userPersistence,
  }) : _userPersistence = userPersistence;

  static UserService _cache;

  final UserRepository _userPersistence;

  /// ユーザーデータを習得します
  Future<User> readUser() async {
    return _userPersistence.readUser();
  }

  /// フレーズをお気に入りに登録します
  Future<User> favorite({
    @required User user,
    @required String listId,
    @required String phraseId,
    @required bool favorite,
  }) async {
    InAppLogger.debug('favorite $favorite');
    final req = FavoritePhraseRequest(
      listId: listId,
      phraseId: phraseId,
      favorite: favorite,
    );
    return _userPersistence.favoritePhrase(req);
  }

  /// 受講可能回数をリセット
  Future<User> resetTestCount({
    @required User user,
  }) async {
    user.statistics.testLimitCount = 3;
    return _userPersistence.updateUser(user);
  }

  /// ポイントを習得します
  Future<User> getPoints({
    @required User user,
    @required int points,
  }) async {
    final req = GetPointRequest(
      points: points,
    );
    return _userPersistence.getPoint(req);
  }

  Future<User> updateAge({@required User user, @required String age}) async {
    user.attributes.age = age;
    return _userPersistence.updateUser(user);
  }

  /// upgrade to Pro or downgrade
  Future<User> changePlan({
    @required User user,
    @required Membership membership,
  }) {
    user.attributes.membership = membership;
    return _userPersistence.updateUser(user);
  }

  /// do test
  Future<User> doTest({
    @required User user,
    @required String sectionId,
  }) {
    return _userPersistence.doTest(DoTestRequest(sectionId: sectionId));
  }

  /// send result
  Future<User> sendTestResult({
    @required User user,
    @required String sectionId,
    @required int score,
  }) {
    return _userPersistence.sendTestResult(
        SendTestResultRequest(sectionId: sectionId, score: score));
  }

  /// update user
  Future<User> updateUser({@required User user}) {
    return _userPersistence.updateUser(user);
  }

  /// create favorite list
  Future<User> createFavoriteList({
    @required String name,
  }) {
    final req = CreateFavoriteListRequest(name: name);
    return _userPersistence.createFavoriteList(req);
  }

  /// delete favorite list
  Future<User> deleteFavoriteList({
    @required String listId,
  }) async {
    final req = DeleteFavoriteListRequest(listId: listId);
    return _userPersistence.deleteFavoriteList(req);
  }

  /// search user from User ID
  Future<User> searchUserFromUserId({@required String userId}) {
    final req = FindUserByUserIdRequest(userId: userId);
    return _userPersistence.findUserByUserId(req);
  }

  /// check test streaks
  Future<bool> checkTestStreaks() {
    final req = CheckTestStreaksRequest();
    return _userPersistence.checkTestStreaks(req);
  }

  /// 友達紹介をする
  Future<void> introduceFriend({@required String introduceeUserId}) {
    final req = IntroduceFriendRequest(introduceeUserId: introduceeUserId);
    return _userPersistence.introduceFriend(req);
  }
}
