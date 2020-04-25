// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/api.dart';
import 'package:wr_app/model/user.dart';

/// debug api
Future<TestResponse> test() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'test')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({});
  final payload = Map.castFrom<dynamic, dynamic, String, dynamic>(result.data);
  return TestResponse.fromJson(payload);
}

/// read user
Future<ReadUserResponse> readUser() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'readUser')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({}).catchError((e) {
    print(e);
    throw e;
  });
  final payload = Map.castFrom<dynamic, dynamic, String, dynamic>(result.data);
  return ReadUserResponse.fromJson(payload);
}

/// create user
Future<CreateUserResponse> createUser() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'createUser')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({}).catchError((e) {
    print(e);
    throw e;
  });

  final payload = Map.castFrom<dynamic, dynamic, String, dynamic>(result.data);
  return CreateUserResponse.fromJson(payload);
}

/// favorite phrase
Future<FavoritePhraseResponse> favoritePhrase(
    {@required String uid,
    @required String phraseId,
    @required bool value}) async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'favoritePhrase')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({
    'uid': uid,
    'phraseId': phraseId,
    'value': value,
  });
  final payload = Map.castFrom<dynamic, dynamic, String, dynamic>(result.data);
  return FavoritePhraseResponse.fromJson(payload);
}
