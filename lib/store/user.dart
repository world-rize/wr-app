// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/user/membership.dart';
import 'package:wr_app/domain/user/user.dart';
import 'package:wr_app/domain/user/user_service.dart';
import 'package:wr_app/store/logger.dart';
import 'package:wr_app/ui/common/toast.dart';

/// ユーザーデータストア
class UserStore with ChangeNotifier {
  final UserService _userService;

  /// ユーザーデータ
  User _user = User.empty();

  /// singleton
  static UserStore _cache;

  factory UserStore({@required UserService service}) {
    if (_cache == null) {
      InAppLogger.log('✨ init UserStore');
      _cache = UserStore._internal(service: service);
    }
    return _cache;
  }

  UserStore._internal({@required UserService service}) : _userService = service;

  Future<void> signUpWithGoogle() async {
    _user = await _userService.signUpWithGoogle();
    InAppLogger.log(_user.toJson().toString(), type: 'user');
  }

  Future<void> signOut() async {
    InAppLogger.log('✔ user signed out', type: 'user');
    return _userService.signOut();
  }

  /// メールアドレスとパスワードでログイン
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    _user = await _userService.signInWithEmailAndPassword(email, password);
    InAppLogger.log('✔ loginWithEmailAndPassword', type: 'user');
    notifyListeners();
  }

  /// Googleでログイン
  Future<void> loginWithGoogle() async {
    _user = await _userService.signUpWithGoogle();
    InAppLogger.log('✔ loginWithGoogle', type: 'user');
    notifyListeners();
  }

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    _user = await _userService.signUpWithEmailAndPassword(email, password);
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

    _user.favorites[phraseId] = value;

    notifyListeners();

    final _res = await _userService
        .favorite(user: _user, phraseId: phraseId, value: value)
        .catchError(NotifyToast.error);

    NotifyToast.success(value ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    InAppLogger.log('resetTestLimitCount()');

    _user.testLimitCount = 3;
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
        .getPoints(user: _user, point: point)
        .catchError(NotifyToast.error);

    _user.point += point;
    notifyListeners();

    NotifyToast.success('$pointポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest() async {
    InAppLogger.log('callDoTest()');

    final _res =
        await _userService.doTest(user: _user).catchError(NotifyToast.error);

    _user.testLimitCount--;
    notifyListeners();
  }

  /// プランを変更
  void changePlan(Membership membership) {
    InAppLogger.log('changePlan()');

    final _res =
        _userService.changePlan(membership).catchError(NotifyToast.error);

    _user.membership = membership;
    notifyListeners();

    InAppLogger.log('membership to be $membership');
    NotifyToast.success('$membership');
  }
}
