// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:wr_app/build/flavor.dart';
import 'package:wr_app/store/logger.dart';

/// システム情報など
class SystemStore with ChangeNotifier {
  /// シングルトンインスタンス
  static SystemStore _cache;

  factory SystemStore({
    @required Flavor flavor,
    @required PackageInfo pubSpec,
    @required Map<String, String> env,
  }) {
    return _cache ??=
        SystemStore._internal(flavor: flavor, pubSpec: pubSpec, env: env);
  }

  SystemStore._internal({
    @required this.flavor,
    @required this.pubSpec,
    @required this.env,
  }) {
    InAppLogger.log('✨ init SystemStore');
  }

  /// flavor
  final Flavor flavor;

  /// pubspec
  final PackageInfo pubSpec;

  /// env
  final Map<String, String> env;
}
