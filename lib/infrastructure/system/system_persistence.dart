// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/util/notification.dart';

class SystemRepository implements ISystemRepository {
  @override
  Future<void> notify({String title, String body, String payload}) {
    final notificator = GetIt.I<AppNotifier>();
    return notificator.showNotification(
        title: title, body: body, payload: payload);
  }

  @override
  void setSetDarkMode({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('dark_mode', value);
  }

  @override
  bool getDarkMode() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('dark_mode') ?? false;
  }

  @override
  void setFollowSystemTheme({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('follow_system_theme', value);
  }

  @override
  bool getFollowSystemTheme() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('follow_system_theme') ?? false;
  }

  @override
  void setFirstLaunch({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('first_launch', value);
  }

  @override
  bool getFirstLaunch() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('first_launch') ?? true;
  }
}
