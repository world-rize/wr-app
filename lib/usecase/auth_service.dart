// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/infrastructure/auth/i_auth_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/user/i_user_repository.dart';
import 'package:wr_app/util/logger.dart';

class AuthService {
  const AuthService({
    @required IAuthRepository authRepository,
    @required IUserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  /// sign up with email & password
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
    @required String age,
  }) async {
    InAppLogger.debug('_userRepository.signUpWithEmailAndPassword()');
    await _authRepository.signUpWithEmailAndPassword(
        email: email, password: password);

    InAppLogger.debug('_userRepository.createUser()');
    final user = await _userRepository.createUser(name: name, email: email);

    InAppLogger.debug('_userRepository.login()');
    await _authRepository.login();

    return user;
  }

  /// sign up with Google
  Future<User> signUpWithGoogle(String name) async {
    InAppLogger.debug('_userRepository.signInWithGoogleSignIn()');
    final fbUser = await _authRepository.signInWithGoogleSignIn();

    InAppLogger.debug('_authRepository.signUpWithGoogle()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');
    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);

    InAppLogger.debug('_userRepository.createUser()');
    final user = _userRepository.createUser(
      name: name,
      email: userName,
    );

    InAppLogger.debug('_authRepository.login()');
    await _authRepository.login();

    return user;
  }

  /// sign up with SIWA
  Future<User> signUpWithApple(String name) async {
    final fbUser = await _authRepository.signInWithSignInWithApple();

    InAppLogger.debug('_authRepository.signUpWithApple()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');

    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);

    InAppLogger.debug('_userRepository.createUser()');
    final user = await _userRepository.createUser(
        name: name, email: fbUser.email ?? '');

    InAppLogger.debug('_authRepository.login()');
    await _authRepository.login();

    return user;
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    InAppLogger.debug('_userRepository.signInWithEmailAndPassword()');
    final res = await _authRepository.signInWithEmailAndPassword(
        email: email, password: password);

    InAppLogger.debug('_userRepository.readUser()');
    final user = await _userRepository.readUser(uuid: res.uid);

    InAppLogger.debug('_authRepository.login()');
    await _authRepository.login();

    return user;
  }

  /// sign in with google
  Future<User> signInWithGoogle() async {
    InAppLogger.debug('_authRepository.signInWithGoogleSignIn()');
    final res = await _authRepository.signInWithGoogleSignIn();

    InAppLogger.debug('_userRepository.readUser()');
    final user = await _userRepository.readUser(uuid: res.uid);

    InAppLogger.debug('_authRepository.login()');
    await _authRepository.login();

    return user;
  }

  /// sign in with apple
  Future<User> signInWithApple() async {
    InAppLogger.debug('_authRepository.signInWithSignInWithApple()');
    final res = await _authRepository.signInWithSignInWithApple();

    InAppLogger.debug('_userRepository.readUser()');
    final user = await _userRepository.readUser(uuid: res.uid);

    InAppLogger.debug('_authRepository.login()');
    await _authRepository.login();

    return user;
  }

  /// sign out
  Future<void> signOut() {
    return _authRepository.signOut();
  }

  /// login
  Future<void> login() {
    return _authRepository.login();
  }

  /// サインイン済か判定
  Future<bool> isAlreadySignedIn() {
    return _authRepository.isAlreadySignedIn();
  }

  /// update password
  Future<void> updatePassword({
    @required String currentPassword,
    @required String newPassword,
  }) {
    return _authRepository.updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }

  /// update email
  Future<User> updateEmail({
    @required User user,
    @required String newEmail,
  }) async {
    user.email = newEmail;
    await _userRepository.updateUser(user: user);
    await _authRepository.updateEmail(email: newEmail);

    return user;
  }

  /// パスワードリセットメールを送る
  Future<void> sendPasswordResetEmail(String email) {
    return _authRepository.sendPasswordResetEmail(email: email);
  }
}
