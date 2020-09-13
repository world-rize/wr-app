// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<FirebaseUser> signUpWithEmailAndPassword(
      String email, String password);

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password);

  Future<FirebaseUser> signInWithGoogleSignIn();

  Future<FirebaseUser> signInWithSignInWithApple(
      {List<Scope> scopes = const []});

  Future<void> updatePassword(String currentPassword, String newPassword);

  Future<void> updateEmail(String email);

  Future<void> sendPasswordResetEmail(String email);

  Future<bool> isAlreadySignedIn();

  Future<void> signOut();
}
