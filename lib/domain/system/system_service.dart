// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/system_repository.dart';
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

  Future<void> notify(
      {AppNotifier notificator, String title, String body, String payload}) {
    return _systemRepository.notify(title: title, body: body, payload: payload);
  }
}
