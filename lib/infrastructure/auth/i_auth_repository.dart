// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class IAuthRepository {
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  Future<User> signInWithEmailAndPassword({
    @required String email,
    String password,
  });

  Future<User> signInWithGoogleSignIn();

  Future<User> signInWithSignInWithApple({List<Scope> scopes = const []});

  Future<void> updatePassword({
    @required String currentPassword,
    @required String newPassword,
  });

  Future<void> updateEmail({
    @required String email,
  });

  Future<void> sendPasswordResetEmail({
    @required String email,
  });

  Future<bool> isAlreadySignedIn();

  Future<void> login();

  Future<void> signOut();
}
