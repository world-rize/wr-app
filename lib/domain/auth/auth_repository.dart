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

  Future<void> signOut();
}

// TODO(some): anti pattern?
/// FireStore Auth
final FirebaseAuth fbAuth = FirebaseAuth.instance;

/// ## firebase ログイン方法
/// - email & password
/// - google sign in
/// - Sign in With Apple
/// - mock(test)
/// ## FirebaseUser -> User
class AuthRepository implements IAuthRepository {
  /// get Google AuthCredential
  // TODO(any): refactoring
  Future<AuthCredential> _getGoogleAuthCredential() async {
    final _googleSignIn = GoogleSignIn();
    // try google sign in
    var _user = _googleSignIn.currentUser;
    _user ??= await _googleSignIn.signInSilently();
    _user ??= await _googleSignIn.signIn();
    if (_user == null) {
      return null;
    }

    // google user -> credential
    final _gauth = await _user.authentication;
    final _credential = GoogleAuthProvider.getCredential(
      idToken: _gauth.idToken,
      accessToken: _gauth.accessToken,
    );

    return _credential;
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

  /// sign out
  @override
  Future<void> signOut() {
    return fbAuth.signOut();
  }
}
