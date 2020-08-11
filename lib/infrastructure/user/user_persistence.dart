// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';

class UserPersistence implements UserRepository {
  @override
  Future<void> test() async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'test')
          ..timeout = const Duration(seconds: 10);
    return callable.call();
  }

  @override
  Future<User> readUser() {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'readUser')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call()
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> createUser(CreateUserRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createUser')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> updateUser(User req) async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'updateUser')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> deleteUser() async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'deleteUser')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call()
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> favoritePhrase(FavoritePhraseRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'favoritePhrase')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> getPoint(GetPointRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'getPoint')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> doTest(DoTestRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'doTest')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> sendTestResult(SendTestResultRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'sendTestResult')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> createFavoriteList(CreateFavoriteListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createFavoriteList')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> deleteFavoriteList(DeleteFavoriteListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'deleteFavoriteList')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> createPhrasesList(CreatePhrasesListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createPhrasesList')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> addPhraseToPhraseList(AddPhraseToPhraseListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'addPhraseToPhraseList')
          ..timeout = const Duration(seconds: 10);

    return callable
        .call(req.toJson())
        .then((res) => User.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<User> updatePhrase(UpdatePhraseRequest req) {
    // TODO: implement updateFavoriteList
    throw UnimplementedError();
  }
}
