// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/model/phrase.dart';

/// debug api
Future<void> test() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'test')
        ..timeout = const Duration(seconds: 10);

  try {
    final result = await callable.call({
      'hoge': 'aaa',
    });

    print(result.data);
  } on CloudFunctionsException catch (e) {
    print(e);
  }
}

/// create user
Future<void> createUser() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'createUser')
        ..timeout = const Duration(seconds: 10);

  try {
    final result = await callable.call({});

    print(result.data);
  } on CloudFunctionsException catch (e) {
    print(e);
  }
}

/// favorite phrase
Future<void> favoritePhrase(String uid, Phrase phrase) async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'favoritePhrase')
        ..timeout = const Duration(seconds: 10);

  try {
    final result = await callable.call({'uid': uid, 'phraseId': phrase.id, ''});

    print(result.data);
  } on CloudFunctionsException catch (e) {
    print(e);
  }
}
