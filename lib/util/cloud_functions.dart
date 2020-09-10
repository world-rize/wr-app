// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wr_app/util/logger.dart';

/// TODO: bad code
bool _useFunctionsEmulator = false;
String _emulatorOrigin = '';

/// Functions のエミュレータを使用
void useCloudFunctionsEmulator(String origin) {
  _useFunctionsEmulator = true;
  _emulatorOrigin = origin;
  InAppLogger.info('🔖 Using Functions emulator @ $origin');
}

/// Cloud Functionの関数を呼び出す
Future<HttpsCallableResult> callFunction(String functionName,
    [dynamic arg = const {}]) {
  // emulator
  if (_useFunctionsEmulator) {
    CloudFunctions.instance.useFunctionsEmulator(origin: _emulatorOrigin);
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: functionName)
          ..timeout = const Duration(seconds: 10);
    return callable.call(arg);
  }

  final callable = CloudFunctions(
    app: FirebaseApp.instance,
    region: 'asia-northeast1',
  ).getHttpsCallable(functionName: functionName)
    ..timeout = const Duration(seconds: 10);
  return callable.call(arg);
}
