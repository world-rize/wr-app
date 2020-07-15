// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:wr_app/domain/system/system_service.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/notification.dart';

/// システム情報など
class SystemNotifier with ChangeNotifier {
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
    _systemService = systemService;
    _notificator.setup();
    InAppLogger.log('✨ init SystemStore');
  }

  SystemService _systemService;

  final _notificator = AppNotifier();

  /// シングルトンインスタンス
  static SystemNotifier _cache;

  /// flavor
  final Flavor flavor;

  /// pubspec
  final PackageInfo pubSpec;

  Future<void> notify() {
    return _systemService.notify(
        notificator: _notificator, title: 'test', body: 'body', payload: 'ok');
  }
}
