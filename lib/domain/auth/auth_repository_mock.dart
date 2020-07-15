// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';

class MockIdTokenResult implements IdTokenResult {
  @override
  String get token => 'fake_token';

  @override
  // TODO: implement authTime
  DateTime get authTime => throw UnimplementedError();

  @override
  // TODO: implement claims
  Map get claims => throw UnimplementedError();

  @override
  // TODO: implement expirationTime
  DateTime get expirationTime => throw UnimplementedError();

  @override
  // TODO: implement issuedAtTime
  DateTime get issuedAtTime => throw UnimplementedError();

  @override
  // TODO: implement signInProvider
  String get signInProvider => throw UnimplementedError();
}

class MockFirebaseUser implements FirebaseUser {
  MockFirebaseUser();

  @override
  String get displayName => 'Hoge';

  @override
  String get uid => '1234-5678-90ab';

  @override
  Future<IdTokenResult> getIdToken({bool refresh = false}) async {
    return Future.value(MockIdTokenResult());
  }

  @override
  Future<void> updatePassword(String password) async {}

  @override
  Future<void> updateEmail(String email) async {}

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement email
  String get email => throw UnimplementedError();

  @override
  // TODO: implement isAnonymous
  bool get isAnonymous => throw UnimplementedError();

  @override
  // TODO: implement isEmailVerified
  bool get isEmailVerified => throw UnimplementedError();

  @override
  Future<AuthResult> linkWithCredential(AuthCredential credential) {
    // TODO: implement linkWithCredential
    throw UnimplementedError();
  }

  @override
  // TODO: implement metadata
  FirebaseUserMetadata get metadata => throw UnimplementedError();

  @override
  // TODO: implement phoneNumber
  String get phoneNumber => throw UnimplementedError();

  @override
  // TODO: implement photoUrl
  String get photoUrl => throw UnimplementedError();

  @override
  // TODO: implement providerData
  List<UserInfo> get providerData => throw UnimplementedError();

  @override
  // TODO: implement providerId
  String get providerId => throw UnimplementedError();

  @override
  Future<AuthResult> reauthenticateWithCredential(AuthCredential credential) {
    // TODO: implement reauthenticateWithCredential
    throw UnimplementedError();
  }

  @override
  Future<void> reload() {
    // TODO: implement reload
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<void> unlinkFromProvider(String provider) {
    // TODO: implement unlinkFromProvider
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhoneNumberCredential(AuthCredential credential) {
    // TODO: implement updatePhoneNumberCredential
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(UserUpdateInfo userUpdateInfo) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}

/// ## firebase ログイン方法
/// - email & password
/// - google sign in
/// - Sign in With Apple
/// - mock(test)
/// ## FirebaseUser -> User
class AuthMockRepository implements IAuthRepository {
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
  Future<void> updatePassword(String newPassword) async {}

  @override
  Future<void> updateEmail(String newEmail) async {}
}
