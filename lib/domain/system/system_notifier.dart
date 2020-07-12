// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:wr_app/domain/system/system_service.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';

/// システム情報など
class SystemNotifier with ChangeNotifier {
  SystemService _systemService;

  /// シングルトンインスタンス
  static SystemNotifier _cache;

  factory SystemNotifier({
    @required SystemService systemService,
    @required Flavor flavor,
    @required PackageInfo pubSpec,
  }) {
    return _cache ??= SystemNotifier._internal(
        systemService: systemService, flavor: flavor, pubSpec: pubSpec);
  }

  SystemNotifier._internal({
    @required SystemService systemService,
    @required this.flavor,
    @required this.pubSpec,
  }) {
    this._systemService = systemService;
    InAppLogger.log('✨ init SystemStore');
  }

  /// flavor
  final Flavor flavor;

  /// pubspec
  final PackageInfo pubSpec;
}
