// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ユーザーデータストア
class OnBoardingNotifier with ChangeNotifier {
  final UserService _userService;
  final SystemService _systemService;

  /// ユーザーデータ
  User _user;

  /// logged in?
  bool get loggedIn => _user != null;

  User getUser() => _user;

  /// singleton
  static OnBoardingNotifier _cache;

  factory OnBoardingNotifier({
    @required UserService userService,
    @required SystemService systemService,
  }) {
    return _cache ??= OnBoardingNotifier._internal(
        userService: userService, systemService: systemService);
  }

  OnBoardingNotifier._internal({
    @required UserService userService,
    @required SystemService systemService,
  })  : _userService = userService,
        _systemService = systemService;

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

  bool getFirstLaunch() => _systemService.getFirstLaunch();

  void setFirstLaunch({bool value}) {
    _systemService.setFirstLaunch(value: value);
    notifyListeners();
  }
}
