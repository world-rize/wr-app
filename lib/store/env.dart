// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';
import 'package:wr_app/build/flavor.dart';
import 'package:wr_app/store/logger.dart';

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
    InAppLogger.log('✨ EnvStore.init()');
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

  /// pref
  bool followSystemTheme = true;
  bool darkMode = false;

  /// 訳を表示するか
  bool showTranslation = false;

  static Future<void> readPubSpec() async {
    final info = await PackageInfo.fromPlatform();
    _cache.version = info.version;
    _cache.appName = info.appName;
    InAppLogger.log('\t📎 read pubspec.yml');
    InAppLogger.log('\t${info.appName} ${info.version}');
  }

  static Future<void> readEnv() async {
    if (_cache.flavor == Flavor.development) {
      const envPath = '.env/.env.development';
      await DotEnv().load(envPath);
      InAppLogger.log('\t📎 read .env');
    }
  }

  void toggleShowTranslation() {
    showTranslation = !showTranslation;
    notifyListeners();
  }

  Map<String, dynamic> get env {
    return DotEnv().env;
  }

  /// App Title
  String appTitle() {
    return '$appName ${flavor.toShortString()} $version';
  }
}
