// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';
import 'package:wr_app/build/flavor.dart';
import 'package:wr_app/store/logger.dart';

/// システム情報など
class SystemStore with ChangeNotifier {
  /// シングルトンインスタンス
  static SystemStore _cache;

  factory SystemStore({@required Flavor flavor}) {
    return _cache ??= SystemStore._internal(flavor: flavor);
  }

  SystemStore._internal({@required Flavor flavor}) {
    init(flavor: flavor);
  }

  Future<void> init({Flavor flavor}) async {
    this.flavor = flavor;
    await readPubSpec();
    await readEnv();
    InAppLogger.log('✨ init SystemStore');
  }

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
    InAppLogger.log('\t📎 read pubspec.yml');
    InAppLogger.log('\t${info.appName} ${info.version}');
  }

  static Future<void> readEnv() async {
    if (_cache.flavor == Flavor.development) {
      const envPath = '.env/.env';
      await DotEnv().load(envPath);
      InAppLogger.log('\t📎 read .env');
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
