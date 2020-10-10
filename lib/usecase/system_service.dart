// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/model/app_info.dart';
import 'package:wr_app/domain/system/system_repository.dart';
import 'package:wr_app/util/notification.dart';

/// singleton
/// 主にデバイスに関するサービスをまとめる
class SystemService {
  factory SystemService({
    @required SystemRepository systemPersistence,
  }) {
    return _cache ??= SystemService._(systemPersistence: systemPersistence);
  }

  SystemService._({
    @required SystemRepository systemPersistence,
  }) : _systemPersistence = systemPersistence;

  static SystemService _cache;
  final SystemRepository _systemPersistence;

  bool getDarkMode() => _systemPersistence.getDarkMode();

  void setDarkMode({bool value}) =>
      _systemPersistence.setSetDarkMode(value: value);

  bool getFollowSystemTheme() => _systemPersistence.getFollowSystemTheme();

  void setFollowSystemTheme({bool value}) =>
      _systemPersistence.setFollowSystemTheme(value: value);

  bool getFirstLaunch() => _systemPersistence.getFirstLaunch();

  void setFirstLaunch({bool value}) =>
      _systemPersistence.setFirstLaunch(value: value);

  bool getQuestionnaireAnswered() =>
      _systemPersistence.getQuestionnaireAnswered();

  void setQuestionnaireAnswered({bool value}) =>
      _systemPersistence.setQuestionnaireAnswered(value: value);

  Future<AppInfo> getAppInfo() => _systemPersistence.getAppInfo();

  Future<void> notify(
      {NotificationNotifier notificator,
      String title,
      String body,
      String payload}) {
    return _systemPersistence.notify(
        title: title, body: body, payload: payload);
  }
}
