// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/infrastructure/auth/i_auth_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/user/i_user_repository.dart';
import 'package:wr_app/util/logger.dart';

// TODO: AuthServiceはUserを知らないべき
class AuthService {
  const AuthService({
    @required IAuthRepository authRepository,
    @required IUserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  /// sign up with email & password
  /// return User
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
    @required String age,
  }) async {
    InAppLogger.debug('_userRepository.signUpWithEmailAndPassword()');
    final fbUser = await _authRepository.signUpWithEmailAndPassword(
        email: email, password: password);

    return User.create()
      ..uuid = fbUser.uid
      ..email = email
      ..name = name
      ..age = age;
  }

  /// sign up with Google
  /// return User.uid
  Future<User> signUpWithGoogle(String name) async {
    InAppLogger.debug('_userRepository.signInWithGoogleSignIn()');
    final fbUser = await _authRepository.signInWithGoogleSignIn();

    InAppLogger.debug('_authRepository.signUpWithGoogle()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');
    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);

    return User.create()
      ..uuid = fbUser.uid
      ..email = fbUser.email
      ..name = userName;
  }

  /// sign up with SIWA
  /// return User.uid
  Future<User> signUpWithApple(String name) async {
    final fbUser = await _authRepository.signInWithSignInWithApple();

    InAppLogger.debug('_authRepository.signUpWithApple()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');

    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);

    return User.create()
      ..uuid = fbUser.uid
      ..name = userName
      ..email = fbUser.email ?? '';
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    InAppLogger.debug('_userRepository.signInWithEmailAndPassword()');
    final res = await _authRepository.signInWithEmailAndPassword(
        email: email, password: password);

    InAppLogger.debug('_userRepository.readUser()');
    final user = await _userRepository.readUser(uuid: res.uid);

    return user;
  }

  /// sign in with google
  Future<User> signInWithGoogle() async {
    InAppLogger.debug('_authRepository.signInWithGoogleSignIn()');
    final res = await _authRepository.signInWithGoogleSignIn();

    InAppLogger.debug('_userRepository.readUser()');
    final user = await _userRepository.readUser(uuid: res.uid);

    return user;
  }

  /// sign in with apple
  Future<User> signInWithApple() async {
    InAppLogger.debug('_authRepository.signInWithSignInWithApple()');
    final res = await _authRepository.signInWithSignInWithApple();

    InAppLogger.debug('_userRepository.readUser()');
    final user = await _userRepository.readUser(uuid: res.uid);

    return user;
  }

  /// sign out
  Future<void> signOut() {
    return _authRepository.signOut();
  }

  /// サインイン済かどうか
  Future<bool> isAlreadySignedIn() {
    return _authRepository.isAlreadySignedIn();
  }

  String getFirebaseUid() {
    return _authRepository.getCurrentUser().uid;
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
