// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/api/model/api.dart';

/// debug api
Future<TestResponse> test() async {
  final callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'test')
        ..timeout = const Duration(seconds: 10);

  final result = await callable.call({});

  // dynamic -> Map<String, dynamic> -> Response
  return TestResponse.fromJson(Map<String, dynamic>.from(result.data));
}
