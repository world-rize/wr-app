// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wr_app/infrastructure/auth/i_auth_repository.dart';
import 'package:wr_app/util/cloud_functions.dart';

class AuthRepository implements IAuthRepository {
  const AuthRepository({
    @required this.auth,
    @required this.googleSignIn,
  });

  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  /// get Google AuthCredential
  Future<AuthCredential> _getGoogleAuthCredential() async {
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
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    final res = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return res.user;
  }

  /// sign in with email & password
  @override
  Future<User> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final res = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return res.user;
  }

  /// sign in with google
  @override
  Future<User> signInWithGoogleSignIn() async {
    final credential = await _getGoogleAuthCredential();
    if (credential == null) {
      throw Exception('GoogleAuthCredential is null');
    }

    // credential -> firebase user
    final authResult = await auth.signInWithCredential(credential);

    return authResult.user;
  }

  /// sign in with sign in apple
  /// <https://codewithandrea.com/videos/2020-01-20-apple-sign-in-flutter-firebase/>
  @override
  Future<User> signInWithSignInWithApple({
    List<Scope> scopes = const [],
  }) async {
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
        final res = await auth.signInWithCredential(credential);
        final user = res.user;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          final displayName = '${fullName.givenName} ${fullName.familyName}';
          await user.updateProfile(displayName: displayName);
        }
        return user;

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
    }
    return null;
  }

  @override
  Future<void> updatePassword({
    @required String currentPassword,
    @required String newPassword,
  }) async {
    final fbUser = auth.currentUser;
    if (fbUser == null) {
      throw Exception('firebase user is null');
    }
    await fbUser.updatePassword(newPassword);
  }

  @override
  Future<void> updateEmail({
    @required String email,
  }) async {
    final fbUser = auth.currentUser;
    if (fbUser == null) {
      throw Exception('firebase user is null');
    }
    await fbUser.updateEmail(email);
  }

  /// sign out
  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  @override
  Future<bool> isAlreadySignedIn() async {
    return auth.currentUser != null;
  }

  @override
  Future<void> sendPasswordResetEmail({@required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> login() {
    return callFunction('login');
  }
}
