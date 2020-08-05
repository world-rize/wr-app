// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/infrastructure/auth/mock_firebase_user.dart';

/// ## firebase ログイン方法
/// - email & password
/// - google sign in
/// - Sign in With Apple
/// - mock(test)
/// ## FirebaseUser -> User
class AuthMockRepository implements AuthRepository {
  // TODO(some): anti pattern?
  /// FireStore Mock Auth
  final FirebaseAuth fbAuth = MockFirebaseAuth();

  /// get Google AuthCredential
  // TODO(any): refactoring
  Future<AuthCredential> _getGoogleAuthCredential() async {
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount.authentication;
    final credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return credential;
  }

  /// メールアドレスとパスワードでサインアップ
  @override
  Future<FirebaseUser> signUpWithEmailAndPassword(
      String email, String password) async {
    return MockFirebaseUser();
  }

  /// sign in with email & password
  @override
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    return MockFirebaseUser();
  }

  /// sign in with google
  @override
  Future<FirebaseUser> signInWithGoogleSignIn() async {
    return MockFirebaseUser();
  }

  /// sign in with sign in apple
  @override
  Future<FirebaseUser> signInWithSignInWithApple() async {
    return MockFirebaseUser();
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
}
