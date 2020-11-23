// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/auth_service.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ログイン等
class AuthNotifier with ChangeNotifier {
  factory AuthNotifier({
    @required AuthService authService,
  }) {
    return _cache ??= AuthNotifier._internal(authService: authService);
  }

  /// singleton
  static AuthNotifier _cache;

  AuthNotifier._internal({
    @required AuthService authService,
  }) {
    _authService = authService;
  }

  AuthService _authService;

  User _user = User.empty();
  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    InAppLogger.info('✔ signUpWithEmailAndPassword');
    _user = await _authService.signUpWithEmailAndPassword(
        email: email, password: password, age: '0', name: name);
    notifyListeners();
  }

  /// Google Sign in でサインアップ
  Future<void> signUpWithGoogle(String name) async {
    _user = await _authService.signUpWithGoogle(name);
    notifyListeners();
  }

  /// Sign up with SIWA
  Future<void> signUpWithApple(String name) async {
    _user = await _authService.signUpWithApple(name);
    notifyListeners();
  }

  /// メールアドレスとパスワードでログイン
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _user = await _authService.signInWithEmailAndPassword(
        email: email, password: password);
    InAppLogger.info('✔ signInWithEmailAndPassword');
    notifyListeners();
  }

  /// Googleでログイン
  Future<void> signInWithGoogle() async {
    _user = await _authService.signInWithGoogle();
    InAppLogger.info('✔ signInWithGoogle');
    notifyListeners();
  }

  /// Sign In With Apple でログイン
  Future<void> signInWithApple() async {
    _user = await _authService.signInWithApple();
    notifyListeners();
  }

  /// ログイン処理をする
  Future<void> login() async {
    await sendEvent(event: AnalyticsEvent.logIn);
    await _authService.login();
    notifyListeners();
  }

  /// サインアウト
  Future<void> signOut() async {
    InAppLogger.info('✔ user signed out');
    return _authService.signOut();
  }

  Future<bool> isAlreadySignedIn() async {
    return _authService.isAlreadySignedIn();
  }

  Future<void> sendPasswordResetEmail() async {
    return _authService.sendPasswordResetEmail(_user.email);
  }

  /// update Email
  Future<void> setEmail({@required String email}) async {
    _user = await _authService.updateEmail(user: _user, newEmail: email);
    notifyListeners();

    NotifyToast.success('Emailを変更しました');
  }

  /// update password
  Future<void> setPassword(
      {@required String currentPassword, @required String newPassword}) async {
    await _authService.updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
    notifyListeners();

    NotifyToast.success('passwordを変更しました');
  }
}
