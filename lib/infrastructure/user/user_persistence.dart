// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/cloud_functions.dart';

class UserPersistence implements UserRepository {
  // TODO: rename XXXPhraseYYY -> XXXNotePhraseYYY?

  @override
  Future<void> test() {
    return callFunction('test');
  }

  @override
  Future<User> readUser() {
    return callFunction('readUser').then((res) => User.fromJson(res.data));
  }

  @override
  Future<void> login() {
    return callFunction('login');
  }

  @override
  Future<User> createUser(CreateUserRequest req) {
    return callFunction('createUser', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> updateUser(User req) {
    return callFunction('updateUser', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> deleteUser() {
    return callFunction('deleteUser').then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> favoritePhrase(FavoritePhraseRequest req) {
    return callFunction('favoritePhrase', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> getPoint(GetPointRequest req) {
    return callFunction('getPoint', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> doTest(DoTestRequest req) {
    return callFunction('doTest', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> sendTestResult(SendTestResultRequest req) {
    return callFunction('sendTestResult', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> createFavoriteList(CreateFavoriteListRequest req) {
    return callFunction('createFavoriteList', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> deleteFavoriteList(DeleteFavoriteListRequest req) {
    return callFunction('deleteFavoriteList', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> createPhrasesList(CreatePhrasesListRequest req) {
    return callFunction('createPhrasesList', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> addPhraseToPhraseList(AddPhraseToPhraseListRequest req) {
    return callFunction('addPhraseToPhraseList', req.toJson())
        .then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> updatePhrase(UpdatePhraseRequest req) {
    // TODO: implement updateFavoriteList
    throw UnimplementedError();
  }

  @override
  Future<User> readUserFromUserId(ReadUserFromUserIdRequest req) async {
    // TODO: implement readUserFromUserId
    return User.dummy()..userId = req.userId;
  }
}
