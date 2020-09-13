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
  Future<User> findUserByUserId(FindUserByUserIdRequest req) async {
    return callFunction('findUserByUserId', req.toJson()).then((res) {
      print(res.data);
      return res;
    }).then((res) => res.data != null ? User.fromJson(res.data) : null);
  }

  @override
  Future<bool> checkTestStreaks(CheckTestStreaksRequest req) {
    return callFunction('checkTestStreaks', req.toJson())
        .then((res) => res.data);
  }

  @override
  Future<User> purchaseItem(PurchaseItemRequest req) {
    // TODO: implement API
    // return callFunction('purchaseItem', req.toJson()).then((res) => res.data);
  }

  @override
  Future<void> introduceFriend(IntroduceFriendRequest req) {
    return callFunction('introduceFriend', req.toJson());
  }
}
