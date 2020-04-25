// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/user.dart';

/// debug api
Future<dynamic> test() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'test')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({});

  return result.data;
}

/// read user
Future<dynamic> readUser() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'readUser')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({});

  return result.data;
}

/// create user
Future<dynamic> createUser() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'createUser')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({});
  return result.data;
}

/// favorite phrase
Future<dynamic> favoritePhrase(String uid, Phrase phrase) async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'favoritePhrase')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({
    'uid': uid,
    'phraseId': phrase.id,
    'value': true,
  });
  return result.data;
}
