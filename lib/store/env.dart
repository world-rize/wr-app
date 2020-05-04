// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wr_app/store/logger.dart';

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
  factory EnvStore({@required Flavor flavor}) {
    _cache.flavor = flavor;

    readEnv();

    return _cache;
  }

  EnvStore._internal();

  Future<void> init() async {
    await readPubSpec();
    await readEnv();
    Logger.log('✨ EnvStore.init()');
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
    Logger.log('\t📎 read pubspec.yml');
    Logger.log('\t${info.appName} ${info.version}');
  }

  static Future<void> readEnv() async {
    if (_cache.flavor == Flavor.development) {
      const envPath = '.env/.env.development';
      await DotEnv().load(envPath);
      Logger.log('\t📎 read .env');
    }
  }

  Map<String, dynamic> get env {
    return DotEnv().env;
  }

  /// App Title
  String appTitle() {
    return '$appName ${flavor.toShortString()} $version';
  }
}
