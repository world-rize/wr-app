// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/logger.dart';

void useCloudFunctionsEmulator(String origin) {
  CloudFunctions.instance.useFunctionsEmulator(origin: origin);
  InAppLogger.info('🔖 Using Functions emulator @ $origin');
}

class UserPersistence implements UserRepository {
  // TODO: rename XXXPhraseYYY -> XXXNotePhraseYYY?

  @override
  Future<void> test() async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'test')
          ..timeout = const Duration(seconds: 10);
    return callable.call();
  }

  @override
  Future<User> readUser() {
    print('hoge');
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'readUser')
          ..timeout = const Duration(seconds: 10);

    return callable.call().then((res) {
      print(res.data['activities']);
      return res;
    }).then((res) => User.fromJson(res.data));
  }

  @override
  Future<void> login() {
    InAppLogger.debug('infra login');
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'login')
          ..timeout = const Duration(seconds: 10);

    return callable.call();
  }

  @override
  Future<User> createUser(CreateUserRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createUser')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> updateUser(User req) async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'updateUser')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> deleteUser() async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'deleteUser')
          ..timeout = const Duration(seconds: 10);

    return callable.call().then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> favoritePhrase(FavoritePhraseRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'favoritePhrase')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> getPoint(GetPointRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'getPoint')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> doTest(DoTestRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'doTest')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> sendTestResult(SendTestResultRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'sendTestResult')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> createFavoriteList(CreateFavoriteListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createFavoriteList')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> deleteFavoriteList(DeleteFavoriteListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'deleteFavoriteList')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> createPhrasesList(CreatePhrasesListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createPhrasesList')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> addPhraseToPhraseList(AddPhraseToPhraseListRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'addPhraseToPhraseList')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => User.fromJson(res.data));
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
