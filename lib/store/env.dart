// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor {
  development,
  staging,
  production,
}

extension FlavorEx on Flavor {
  String toShortString() {
    return toString().split('.').last;
  }
}

/// Env
class EnvStore with ChangeNotifier {
  factory EnvStore({Flavor flavor}) {
    _cache.flavor = flavor;

    readEnv();

    return _cache;
  }

  EnvStore._internal() {
    print('EnvStore#_internal');
    readPubSpec();
  }

  /// シングルトンインスタンス
  static final EnvStore _cache = EnvStore._internal();

  /// flavor
  Flavor flavor;

  /// appName
  String appName;

  /// version
  String version;

  /// author
  String author = '';

  static Future<void> readPubSpec() async {
    final info = await PackageInfo.fromPlatform();
    _cache.version = info.version;
    _cache.appName = info.appName;
  }

  static Future<void> readEnv() async {
    if (_cache.flavor == Flavor.development) {
      await DotEnv().load('.env/.env.development');
      print('.env loaded');
      print(DotEnv().env);
    }
  }

  /// App Title
  String appTitle() {
    return '$appName ${flavor.toShortString()} $version';
  }
}
