// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';

class UserPersistenceMock implements UserRepository {
  @override
  Future<void> test() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User> readUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return User.dummy();
  }

  @override
  Future<User> createUser(CreateUserRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
    return User.dummy();
  }

  @override
  Future<User> updateUser(User req) async {
    await Future.delayed(const Duration(seconds: 1));
    return User.dummy();
  }

  @override
  Future<void> deleteUser() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> favoritePhrase(FavoritePhraseRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> getPoint(GetPointRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> doTest(DoTestRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendTestResult(SendTestResultRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> createFavoriteList(CreateFavoriteListRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> deleteFavoriteList(DeleteFavoriteListRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> createPhrasesList(CreatePhrasesListRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> addPhraseToPhraseList(AddPhraseToPhraseListRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
