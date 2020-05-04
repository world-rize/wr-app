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

  // dynamic -> Map<String, dynamic> -> Response
  return TestResponse.fromJson(Map<String, dynamic>.from(result.data));
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

  // dynamic -> Map<String, dynamic> -> Response
  return ReadUserResponse.fromJson(Map<String, dynamic>.from(result.data));
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

  // dynamic -> Map<String, dynamic> -> Response
  return CreateUserResponse.fromJson(Map<String, dynamic>.from(result.data));
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

  // dynamic -> Map<String, dynamic> -> Response
  return FavoritePhraseResponse.fromJson(
      Map<String, dynamic>.from(result.data));
}

/// get point
Future<GetPointResponse> getPoint(
    {@required String uid, @required int point}) async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'getPoint')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({
    'uid': uid,
    'point': point,
  });

  // dynamic -> Map<String, dynamic> -> Response
  return GetPointResponse.fromJson(Map<String, dynamic>.from(result.data));
}
