// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';

/// instead of mock_firebase
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
