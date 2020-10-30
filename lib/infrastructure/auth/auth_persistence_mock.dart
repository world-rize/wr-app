// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';

/// ## firebase ログイン方法
/// - email & password
/// - google sign in
/// - Sign in With Apple
/// - mock(test)
/// ## FirebaseUser -> User
class AuthPersistenceMock implements AuthRepository {
  /// FireStore Mock Auth
  final FirebaseAuth fbAuth = MockFirebaseAuth();

  /// get Google AuthCredential
  // TODO(any): refactoring
  Future<AuthCredential> _getGoogleAuthCredential() async {
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return credential;
  }

  /// メールアドレスとパスワードでサインアップ
  @override
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    return fbAuth.currentUser;
  }

  /// sign in with email & password
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return fbAuth.currentUser;
  }

  /// sign in with google
  @override
  Future<User> signInWithGoogleSignIn() async {
    return fbAuth.currentUser;
  }

  /// sign in with sign in apple
  @override
  Future<User> signInWithSignInWithApple(
      {List<Scope> scopes = const []}) async {
    return fbAuth.currentUser;
  }

  /// sign out
  @override
  Future<void> signOut() {
    return fbAuth.signOut();
  }

  @override
  Future<void> updatePassword(
      String currentPassword, String newPassword) async {}

  @override
  Future<void> updateEmail(String newEmail) async {}

  @override
  Future<bool> isAlreadySignedIn() async {
    return false;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // noop
  }

  @override
  Future<void> login() async {
    // noop
  }
}
