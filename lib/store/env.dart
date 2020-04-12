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
    return _cache;
  }

  EnvStore._internal() {
    readPubSpec();

    if (flavor == Flavor.development) {
      DotEnv().load('.env/.env.development').then((value) {
        print('.env loaded');
        print(DotEnv().env);
      });
    }
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

  Future<void> readPubSpec() async {
    final info = await PackageInfo.fromPlatform();
    _cache.version = info.version;
    _cache.appName = info.appName;
    notifyListeners();
  }

  /// App Title
  String appTitle() {
    return '$appName ${flavor.toShortString()} $version';
  }
}
