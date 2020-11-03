// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/util/cloud_functions.dart';

/// ## firebase ログイン方法
/// - email & password
/// - google sign in
/// - Sign in With Apple
/// - mock(test)
/// ## FirebaseUser -> User
class AuthPersistence implements AuthRepository {
  // TODO(some): anti pattern?
  /// FireStore Auth
  // NOTE: fbAuth = FirebaseAuth.instance だと止まってしまう
  FirebaseAuth get fbAuth => FirebaseAuth.instance;

  /// get Google AuthCredential
  // TODO(any): refactoring
  Future<AuthCredential> _getGoogleAuthCredential() async {
    final googleSignIn = GoogleSignIn();
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
  Future<User> signUpWithEmailAndPassword(String email, String password) {
    return fbAuth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((res) => res.user);
  }

  /// sign in with email & password
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) {
    return fbAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((res) => res.user);
  }

  /// sign in with google
  @override
  Future<User> signInWithGoogleSignIn() async {
    final credential = await _getGoogleAuthCredential();
    if (credential == null) {
      throw Exception('GoogleAuthCredential is null');
    }

    // credential -> firebase user
    final authResult = await fbAuth.signInWithCredential(credential);

    return authResult.user;
  }

  /// sign in with sign in apple
  /// <https://codewithandrea.com/videos/2020-01-20-apple-sign-in-flutter-firebase/>
  @override
  Future<User> signInWithSignInWithApple(
      {List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await fbAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          final displayName = '${fullName.givenName} ${fullName.familyName}';
          await firebaseUser.updateProfile(displayName: displayName);
        }
        return firebaseUser;

      case AuthorizationStatus.error:
        print(result.error.toString());
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw PlatformException(
          code: 'ERROR_UNHANDLED_VALUE',
          message: '${StackTrace.current}',
        );
    }
  }

  @override
  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final fbUser = fbAuth.currentUser;
    if (fbUser == null) {
      throw Exception('firebase user is null');
    }
    await fbUser.updatePassword(newPassword);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    final fbUser = fbAuth.currentUser;
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

  @override
  Future<bool> isAlreadySignedIn() async {
    return fbAuth.currentUser != null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await fbAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> login() {
    return callFunction('login');
  }
}
