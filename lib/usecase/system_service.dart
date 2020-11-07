// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/model/app_info.dart';
import 'package:wr_app/infrastructure/system/i_system_repository.dart';
import 'package:wr_app/util/notification.dart';

class SystemService {
  final ISystemRepository _systemRepository;

  const SystemService({
    @required ISystemRepository systemRepository,
  }) : _systemRepository = systemRepository;

  bool getDarkMode() => _systemRepository.getDarkMode();

  void setDarkMode({bool value}) =>
      _systemRepository.setSetDarkMode(value: value);

  bool getFollowSystemTheme() => _systemRepository.getFollowSystemTheme();

  void setFollowSystemTheme({bool value}) =>
      _systemRepository.setFollowSystemTheme(value: value);

  bool getFirstLaunch() => _systemRepository.getFirstLaunch();

  void setFirstLaunch({bool value}) =>
      _systemRepository.setFirstLaunch(value: value);

  bool getQuestionnaireAnswered() =>
      _systemRepository.getQuestionnaireAnswered();

  void setQuestionnaireAnswered({bool value}) =>
      _systemRepository.setQuestionnaireAnswered(value: value);

  Future<AppInfo> getAppInfo() => _systemRepository.getAppInfo();

  Future<void> notify(
      {NotificationNotifier notificator,
      String title,
      String body,
      String payload}) {
    return _systemRepository.notify(
        title: title, body: body, payload: payload);
  }
}
