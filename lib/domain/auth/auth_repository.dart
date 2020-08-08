// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<FirebaseUser> signUpWithEmailAndPassword(
      String email, String password);

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password);

  Future<FirebaseUser> signInWithGoogleSignIn();

  Future<FirebaseUser> signInWithSignInWithApple();

  Future<void> updatePassword(String currentPassword, String newPassword);

  Future<void> updateEmail(String email);

  Future<void> signOut();
}
