// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/auth_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ログイン等
class AuthNotifier with ChangeNotifier {
  factory AuthNotifier({
    @required AuthService authService,
    @required UserService userService,
  }) {
    return _cache ??= AuthNotifier._internal(
        authService: authService, userService: userService);
  }

  AuthNotifier._internal({
    @required AuthService authService,
    @required UserService userService,
  }) {
    _authService = authService;
    _userService = userService;
  }

  /// singleton
  static AuthNotifier _cache;

  AuthService _authService;
  UserService _userService;

  User _user = User.empty();

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  /// メールアドレスとパスワードでサインアップと初期化
  Future<void> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    InAppLogger.info('✔ signUpWithEmailAndPassword');
    _user = await _authService.signUpWithEmailAndPassword(
        email: email, password: password, age: '0', name: name);
    await _userService.initializeUserData(
      uid: _user.uuid,
      name: name,
      email: email,
    );
    notifyListeners();
  }

  /// Google Sign in でサインアップと初期化
  Future<void> signUpWithGoogle(String name) async {
    _user = await _authService.signUpWithGoogle(name);
    await _userService.initializeUserData(
      uid: _user.uuid,
      email: _user.email,
      name: _user.name,
    );
    notifyListeners();
  }

  /// Sign up with SIWAと初期化
  Future<void> signUpWithApple(String name) async {
    _user = await _authService.signUpWithApple(name);
    await _userService.initializeUserData(
      uid: _user.uuid,
      email: _user.email,
      name: _user.name,
    );
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

  /// アプリのログイン処理をする
  Future<void> login() async {
    await sendEvent(event: AnalyticsEvent.logIn);
    final uid = getFirebaseUid();
    await _userService.migrationUserData(uid: uid);
    user = await _userService.fetchUser(uid: uid);
    await _userService.setTestCount(user: user, count: 3);
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

  /// firebaseでログイン中のuidを取得する
  String getFirebaseUid() {
    return _authService.getFirebaseUid();
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
