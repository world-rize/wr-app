// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wr_app/util/logger.dart';

/// Functions のエミュレータを使用
void useCloudFunctionsEmulator(String origin) {
  CloudFunctions.instance.useFunctionsEmulator(origin: origin);
  InAppLogger.info('🔖 Using Functions emulator @ $origin');
}

/// Cloud Functionの関数を呼び出す
Future<R> callFunction<R>(String functionName, [dynamic arg = const {}]) {
  final callable = CloudFunctions(
    app: FirebaseApp.instance,
    region: 'asia-northeast1',
  ).getHttpsCallable(functionName: functionName)
    ..timeout = const Duration(seconds: 10);
  return callable.call(arg).then((res) => res.data);
}
