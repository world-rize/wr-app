// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:collection/collection.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/api/functions.dart';
import 'package:wr_app/infrastructure/auth/i_auth_repository.dart';
import 'package:wr_app/infrastructure/lesson/i_favorite_repository.dart';
import 'package:wr_app/infrastructure/note/i_note_repository.dart';
import 'package:wr_app/infrastructure/user/i_user_repository.dart';
import 'package:wr_app/util/logger.dart';

// TODO: Error handling
class UserService {
  const UserService({
    @required IAuthRepository authRepository,
    @required IUserRepository userRepository,
    @required IFavoriteRepository favoriteRepository,
    @required INoteRepository noteRepository,
    @required IUserAPI userApi,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _favoriteRepository = favoriteRepository,
        _noteRepository = noteRepository,
        _userApi = userApi;

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IFavoriteRepository _favoriteRepository;
  final INoteRepository _noteRepository;
  final UserAPI _userApi;

  /// ユーザのすべてのデータの初期化
  Future<void> initializeUserData({
    @required String uid,
    @required String name,
    @required String email,
  }) async {
    InAppLogger.debug('_userRepository.createUser()');
    final newUser = User.create()
      ..uuid = uid
      ..email = email
      ..name = name
      ..membership = Membership.pro;

    await _userRepository.createUser(user: newUser);
    await _favoriteRepository.createFavoriteList(
      userUuid: uid,
      title: '',
      isDefault: true,
    );

    final defaultNote = Note.create(title: 'default', isDefault: true);
    final achievedNote = Note.create(title: 'achieved', isAchieved: true);
    await _noteRepository.createNote(user: newUser, note: defaultNote);
    await _noteRepository.createNote(user: newUser, note: achievedNote);
  }

  /// 前のバージョンのユーザからデータを再帰的にマイグレーションする
  Future<void> migrationUserData({@required String uid}) async {
    // TODO
  }

  // TODO: どこにおくべき
  String getUid() {
    return _authRepository.getCurrentUser()?.uid ?? '';
  }

  Future<User> fetchUser({@required String uid}) async {
    return _userRepository.readUser(uuid: uid);
  }

  /// 受講可能回数をセット
  Future<User> setTestCount({
    @required User user,
    @required int count,
  }) async {
    user.testLimitCount = count;
    return _userRepository.updateUser(user: user);
  }

  /// ポイントを習得します
  Future<User> getPoints({
    @required User user,
    @required int points,
  }) async {
    user.points += points;
    return _userRepository.updateUser(user: user);
  }

  /// upgrade to Pro or downgrade
  Future<User> changePlan({
    @required User user,
    @required Membership membership,
  }) {
    user.membership = membership;
    return _userRepository.updateUser(user: user);
  }

  /// do test
  Future<User> doTest({
    @required User user,
    @required String sectionId,
  }) {
    if (user.testLimitCount == 0) {
      throw Exception('daily test limit exceeded');
    }

    user.testLimitCount -= 1;

    return _userRepository.updateUser(user: user);
  }

  /// send result
  Future<User> sendTestResult({
    @required User user,
    @required String sectionId,
    @required int score,
  }) {
    // 記録追加
    user.testResults.add(TestResult(
      sectionId: sectionId,
      score: score,
      date: DateTime.now().toIso8601String(),
    ));

    return _userRepository.updateUser(user: user);
  }

  /// update user
  Future<User> updateUser({@required User user}) {
    return _userRepository.updateUser(user: user);
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
    final last30daysResults =
        user.testResults.where((result) => Jiffy(result.date).isAfter(begin));
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
