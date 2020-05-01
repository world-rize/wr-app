// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
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
    dev.log('✨ EnvStore._internal()');
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
    dev.log('\t📎 read pubspec.yml');
    dev.log('\t${info.appName} ${info.version}');
  }

  static Future<void> readEnv() async {
    if (_cache.flavor == Flavor.development) {
      const envPath = '.env/.env.development';
      await DotEnv().load(envPath);
      dev.log('\t📎 read .env');
    }
  }

  /// App Title
  String appTitle() {
    return '$appName ${flavor.toShortString()} $version';
  }
}
