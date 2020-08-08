// Copyright © 2020 WorldRIZe. All rights reserved.

abstract class SystemRepository {
  Future<void> notify({String title, String body, String payload});

  bool getFollowSystemTheme();
  void setFollowSystemTheme({bool value});

  bool getDarkMode();
  void setSetDarkMode({bool value});

  bool getFirstLaunch();
  void setFirstLaunch({bool value});
}
