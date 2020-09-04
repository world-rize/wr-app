// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/system_repository.dart';
import 'package:wr_app/util/notification.dart';

class SystemService {
  final SystemRepository _systemPersistence;

  const SystemService({
    @required SystemRepository systemPersistence,
  }) : _systemPersistence = systemPersistence;

  bool getDarkMode() => _systemPersistence.getDarkMode();

  void setDarkMode({bool value}) =>
      _systemPersistence.setSetDarkMode(value: value);

  bool getFollowSystemTheme() => _systemPersistence.getFollowSystemTheme();

  void setFollowSystemTheme({bool value}) =>
      _systemPersistence.setFollowSystemTheme(value: value);

  bool getFirstLaunch() => _systemPersistence.getFirstLaunch();

  void setFirstLaunch({bool value}) =>
      _systemPersistence.setFirstLaunch(value: value);

  Future<void> notify(
      {AppNotifier notificator, String title, String body, String payload}) {
    return _systemPersistence.notify(
        title: title, body: body, payload: payload);
  }
}