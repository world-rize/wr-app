// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/user_service.dart';
import 'package:wr_app/ui/common/toast.dart';
import 'package:wr_app/util/logger.dart';

/// ユーザーデータストア
class UserNotifier with ChangeNotifier {
  final UserService _userService;

  /// ユーザーデータ
  User user = User.empty();

  /// singleton
  static UserNotifier _cache;

  factory UserNotifier({@required UserService service}) {
    if (_cache == null) {
      InAppLogger.log('✨ init UserStore');
      _cache = UserNotifier._internal(service: service);
    }
    return _cache;
  }

  UserNotifier._internal({@required UserService service})
      : _userService = service;

  Future<void> signUpWithGoogle() async {
    user = await _userService.signUpWithGoogle();
    InAppLogger.log(user.toJson().toString(), type: 'user');
  }

  Future<void> signOut() async {
    InAppLogger.log('✔ user signed out', type: 'user');
    return _userService.signOut();
  }

  /// メールアドレスとパスワードでログイン
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    user = await _userService.signInWithEmailAndPassword(email, password);
    InAppLogger.log('✔ loginWithEmailAndPassword', type: 'user');
    notifyListeners();
  }

  /// Googleでログイン
  Future<void> loginWithGoogle() async {
    user = await _userService.signUpWithGoogle();
    InAppLogger.log('✔ loginWithGoogle', type: 'user');
    notifyListeners();
  }

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    user = await _userService.signUpWithEmailAndPassword(email, password);
    InAppLogger.log('✔ signUpWithEmailAndPassword', type: 'user');
    notifyListeners();
  }

  Future<void> test() async {
    InAppLogger.log('callTestAPI()');
    await _userService.test();
    notifyListeners();
  }

  /// フレーズをお気に入りに登録します
  Future<void> favoritePhrase({
    @required String phraseId,
    @required bool value,
  }) async {
    InAppLogger.log('favoritePhrase()');

    user.favorites[phraseId] = value;

    notifyListeners();

    final _res = await _userService
        .favorite(user: user, phraseId: phraseId, value: value)
        .catchError(NotifyToast.error);

    NotifyToast.success(value ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    InAppLogger.log('resetTestLimitCount()');

    user.testLimitCount = 3;
    notifyListeners();

    final _res =
        await _userService.resetTestCount().catchError(NotifyToast.error);

    InAppLogger.log('受講可能回数がリセットされました');
    NotifyToast.success('受講可能回数がリセットされました');
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int point}) async {
    InAppLogger.log('callGetPoint()');

    final _res = await _userService
        .getPoints(user: user, point: point)
        .catchError(NotifyToast.error);

    user.point += point;
    notifyListeners();

    NotifyToast.success('$pointポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest() async {
    InAppLogger.log('callDoTest()');

    final _res =
        await _userService.doTest(user: user).catchError(NotifyToast.error);

    user.testLimitCount--;
    notifyListeners();
  }

  /// プランを変更
  void changePlan(Membership membership) {
    InAppLogger.log('changePlan()');

    final _res =
        _userService.changePlan(membership).catchError(NotifyToast.error);

    user.membership = membership;
    notifyListeners();

    InAppLogger.log('membership to be $membership');
    NotifyToast.success('$membership');
  }
}
