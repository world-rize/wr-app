// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/user_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ユーザーデータストア
class UserNotifier with ChangeNotifier {
  final UserService _userService;

  /// ユーザーデータ
  User _user;

  /// logged in?
  bool get loggedIn => _user != null;

  User getUser() => _user;

  /// singleton
  static UserNotifier _cache;

  factory UserNotifier({@required UserService service}) {
    return _cache ??= UserNotifier._internal(service: service);
  }

  UserNotifier._internal({@required UserService service})
      : _userService = service;

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

    NotifyToast.success('ログインしました');
  }

  /// update Email
  Future<void> setEmail({@required String email}) async {
    _user = await _userService.updateEmail(user: _user, newEmail: email);
    notifyListeners();

    NotifyToast.success('Emailを変更しました');
  }

  /// update age
  Future<void> setAge({@required String age}) async {
    _user = await _userService.updateAge(user: _user, age: age);
    notifyListeners();

    NotifyToast.success('ageを変更しました');
  }

  /// update password
  Future<void> setPassword(
      {@required String currentPassword, @required String newPassword}) async {
    await _userService.updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
    notifyListeners();

    NotifyToast.success('passwordを変更しました');
  }

  /// Test API
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
    // 仮反映
    _user.favorites[phraseId] = value;
    notifyListeners();

    // 本反映
    _user = await _userService.favorite(
        user: _user, phraseId: phraseId, value: value);
    notifyListeners();

    NotifyToast.success(value ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    _user = await _userService.resetTestCount(user: _user);

    notifyListeners();

    InAppLogger.log('受講可能回数がリセットされました');
    NotifyToast.success('受講可能回数がリセットされました');
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int point}) async {
    _user = await _userService.getPoints(user: _user, point: point);
    notifyListeners();

    NotifyToast.success('$pointポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest() async {
    _user = await _userService.doTest(user: _user);
    notifyListeners();
  }

  /// プランを変更
  Future<void> changePlan(Membership membership) async {
    _user = await _userService.changePlan(user: _user, membership: membership);

    notifyListeners();

    InAppLogger.log('membership to be $membership');
    NotifyToast.success('$membership');
  }
}