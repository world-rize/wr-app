// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/logger.dart';

/// 認証に係るサービスをまとめる
class AuthService {
  AuthService({
    @required AuthRepository authPersistence,
    @required UserRepository userPersistence,
  })  : _authPersistence = authPersistence,
        _userPersistence = userPersistence;

  final AuthRepository _authPersistence;
  final UserRepository _userPersistence;

  /// sign up with email & password
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
    @required String age,
  }) async {
    final req = CreateUserRequest(
      name: name,
      age: age,
      email: email,
    );

    InAppLogger.debug('_userPersistence.signUpWithEmailAndPassword()');
    await _authPersistence.signUpWithEmailAndPassword(email, password);

    InAppLogger.debug('_userPersistence.createUser()');
    final user = await _userPersistence.createUser(req);

    InAppLogger.debug('_userPersistence.login()');
    await _authPersistence.login();

    return user;
  }

  /// sign up with Google
  Future<User> signUpWithGoogle(String name) async {
    InAppLogger.debug('_userPersistence.signInWithGoogleSignIn()');
    final fbUser = await _authPersistence.signInWithGoogleSignIn();

    InAppLogger.debug('_authPersistence.signUpWithGoogle()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');
    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);
    final req = CreateUserRequest(
      name: userName,
      email: fbUser.email,
      age: '0',
    );

    InAppLogger.debug('_userPersistence.createUser()');
    final user = _userPersistence.createUser(req);

    InAppLogger.debug('_authPersistence.login()');
    await _authPersistence.login();

    return user;
  }

  /// sign up with SIWA
  Future<User> signUpWithApple(String name) async {
    final fbUser = await _authPersistence.signInWithSignInWithApple();

    InAppLogger.debug('_authPersistence.signUpWithApple()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');

    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);
    final req = CreateUserRequest(
      name: name,
      email: fbUser.email ?? '',
      age: '0',
    );

    InAppLogger.debug('_userPersistence.createUser()');
    final user = await _userPersistence.createUser(req);

    InAppLogger.debug('_authPersistence.login()');
    await _authPersistence.login();

    return user;
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    InAppLogger.debug('_userPersistence.signInWithEmailAndPassword()');
    await _authPersistence.signInWithEmailAndPassword(email, password);

    InAppLogger.debug('_userPersistence.readUser()');
    final user = await _userPersistence.readUser();

    InAppLogger.debug('_authPersistence.login()');
    await _authPersistence.login();

    return user;
  }

  /// sign in with google
  Future<User> signInWithGoogle() async {
    InAppLogger.debug('_authPersistence.signInWithGoogleSignIn()');
    await _authPersistence.signInWithGoogleSignIn();

    InAppLogger.debug('_userPersistence.readUser()');
    final user = await _userPersistence.readUser();

    InAppLogger.debug('_authPersistence.login()');
    await _authPersistence.login();

    return user;
  }

  /// sign in with apple
  Future<User> signInWithApple() async {
    InAppLogger.debug('_authPersistence.signInWithSignInWithApple()');
    await _authPersistence.signInWithSignInWithApple();

    InAppLogger.debug('_userPersistence.readUser()');
    final user = await _userPersistence.readUser();

    InAppLogger.debug('_authPersistence.login()');
    await _authPersistence.login();

    return user;
  }

  /// sign out
  Future<void> signOut() {
    return _authPersistence.signOut();
  }

  /// login
  Future<void> login() {
    return _authPersistence.login();
  }

  /// サインイン済か判定
  Future<bool> isAlreadySignedIn() {
    return _authPersistence.isAlreadySignedIn();
  }

  /// update password
  Future<void> updatePassword({
    @required String currentPassword,
    @required String newPassword,
  }) {
    return _authPersistence.updatePassword(currentPassword, newPassword);
  }

  /// update email
  Future<User> updateEmail({
    @required User user,
    @required String newEmail,
  }) async {
    user.attributes.email = newEmail;
    await _userPersistence.updateUser(user);
    await _authPersistence.updateEmail(newEmail);

    return user;
  }

  /// パスワードリセットメールを送る
  Future<void> sendPasswordResetEmail(String email) {
    return _authPersistence.sendPasswordResetEmail(email);
  }
}
