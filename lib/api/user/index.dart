// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/api/model/api.dart';

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
Future<CreateUserResponse> createUser({
  @required String uuid,
  @required String name,
  @required String userId,
  @required String email,
  @required int age,
}) async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'createUser')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({
    'uuid': uuid,
    'name': name,
    'userId': userId,
    'email': email,
    'age': age,
  }).catchError((e) {
    print(e);
    throw e;
  });

  // dynamic -> Map<String, dynamic> -> Response
  return CreateUserResponse.fromJson(Map<String, dynamic>.from(result.data));
}

/// favorite phrase
Future<FavoritePhraseResponse> favoritePhrase({
  @required String uid,
  @required String phraseId,
  @required bool value,
}) async {
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

/// テストを受ける
Future<void> doTest() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'doTest')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({});

  // dynamic -> Map<String, dynamic> -> Response
  return;
  // return TestResponse.fromJson(Map<String, dynamic>.from(result.data));
}
