// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthRepository {
  Future<FirebaseUser> signUpWithEmailAndPassword(
      String email, String password);

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password);

  Future<FirebaseUser> signInWithGoogleSignIn();

  Future<FirebaseUser> signInWithSignInWithApple();

  Future<void> updatePassword(String newPassword);

  Future<void> updateEmail(String email);

  Future<void> signOut();
}

/// ## firebase ログイン方法
/// - email & password
/// - google sign in
/// - Sign in With Apple
/// - mock(test)
/// ## FirebaseUser -> User
class AuthRepository implements IAuthRepository {
  // TODO(some): anti pattern?
  /// FireStore Auth
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  /// get Google AuthCredential
  // TODO(any): refactoring
  Future<AuthCredential> _getGoogleAuthCredential() async {
    final googleSignIn = GoogleSignIn();
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
      String email, String password) {
    return fbAuth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((res) => res.user);
  }

  /// sign in with email & password
  @override
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) {
    return fbAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((res) => res.user);
  }

  /// sign in with google
  @override
  Future<FirebaseUser> signInWithGoogleSignIn() async {
    final _credential = await _getGoogleAuthCredential();
    assert(_credential != null);

    // credential -> firebase user
    final authResult =
        await fbAuth.signInWithCredential(_credential).catchError(print);

    assert(authResult != null);

    return authResult.user;
  }

  /// sign in with sign in apple
  @override
  Future<FirebaseUser> signInWithSignInWithApple() async {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final fbUser = await fbAuth.currentUser();
    if (fbUser == null) {
      throw Exception('firebase user is null');
    }
    await fbUser.updatePassword(newPassword);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    final fbUser = await fbAuth.currentUser();
    if (fbUser == null) {
      throw Exception('firebase user is null');
    }
    await fbUser.updateEmail(newEmail);
  }

  /// sign out
  @override
  Future<void> signOut() {
    return fbAuth.signOut();
  }
}
