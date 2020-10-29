// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> signUpWithEmailAndPassword(String email, String password);

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> signInWithGoogleSignIn();

  Future<User> signInWithSignInWithApple({List<Scope> scopes = const []});

  Future<void> updatePassword(String currentPassword, String newPassword);

  Future<void> updateEmail(String email);

  Future<void> sendPasswordResetEmail(String email);

  Future<bool> isAlreadySignedIn();

  Future<void> login();

  Future<void> signOut();
}
