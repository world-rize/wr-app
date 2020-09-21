// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/system/model/app_info.dart';
import 'package:wr_app/usecase/system_service.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';

/// システム情報など
class SystemNotifier with ChangeNotifier {
  factory SystemNotifier({
    @required SystemService systemService,
    @required Flavor flavor,
  }) {
    return _cache ??=
        SystemNotifier._internal(systemService: systemService, flavor: flavor);
  }

  SystemNotifier._internal({
    @required SystemService systemService,
    @required this.flavor,
  }) {
    _systemService = systemService;
  }

  SystemService _systemService;

  /// シングルトンインスタンス
  static SystemNotifier _cache;

  /// flavor
  final Flavor flavor;

  ThemeMode getThemeMode() {
    if (getFollowSystemTheme()) {
      return ThemeMode.system;
    } else if (getDarkMode()) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  bool getDarkMode() => _systemService.getDarkMode();

  void setDarkMode({bool value}) {
    _systemService.setDarkMode(value: value);
    notifyListeners();
  }

  bool getFollowSystemTheme() => _systemService.getFollowSystemTheme();

  void setFollowSystemTheme({bool value}) {
    _systemService.setFollowSystemTheme(value: value);
    notifyListeners();
  }

  bool getFirstLaunch() => _systemService.getFirstLaunch();

  void setFirstLaunch({bool value}) {
    _systemService.setFirstLaunch(value: value);

    InAppLogger.info('setFirstLaunch -> $value');

    notifyListeners();
  }

  bool getQuestionnaireAnswered() => _systemService.getQuestionnaireAnswered();

  void setQuestionnaireAnswered({bool value}) {
    _systemService.setQuestionnaireAnswered(value: value);

    InAppLogger.info('getQuestionnaireAnswered -> $value');

    notifyListeners();
  }

  Future<AppInfo> getAppInfo() async {
    return _systemService.getAppInfo();
  }

  Future<void> notify({
    @required String title,
    @required String body,
    @required String payload,
  }) {
    return _systemService.notify(title: title, body: body, payload: payload);
  }
}
