// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/model/app_info.dart';
import 'package:wr_app/domain/system/system_repository.dart';
import 'package:wr_app/util/notification.dart';

class SystemService {
  final SystemRepository _systemPersistence;

  const SystemService({
    required SystemRepository systemPersistence,
  }) : _systemPersistence = systemPersistence;

  bool getDarkMode() => _systemPersistence.getDarkMode();

  void setDarkMode({required bool value}) =>
      _systemPersistence.setSetDarkMode(value: value);

  bool getFollowSystemTheme() => _systemPersistence.getFollowSystemTheme();

  void setFollowSystemTheme({required bool value}) =>
      _systemPersistence.setFollowSystemTheme(value: value);

  bool getFirstLaunch() => _systemPersistence.getFirstLaunch();

  void setFirstLaunch({required bool value}) =>
      _systemPersistence.setFirstLaunch(value: value);

  bool getQuestionnaireAnswered() =>
      _systemPersistence.getQuestionnaireAnswered();

  void setQuestionnaireAnswered({required bool value}) =>
      _systemPersistence.setQuestionnaireAnswered(value: value);

  Future<AppInfo> getAppInfo() => _systemPersistence.getAppInfo();

  Future<void> notify({
    required String title,
    required String body,
    required String payload,
  }) {
    return _systemPersistence.notify(
        title: title, body: body, payload: payload);
  }
}
