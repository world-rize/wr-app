// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/system/model/app_info.dart';

abstract class SystemRepository {
  Future<void> notify({String title, String body, String payload});

  // テーマ: システムに従う
  bool getFollowSystemTheme();
  void setFollowSystemTheme({bool value});

  // テーマ: ダークモード
  bool getDarkMode();
  void setSetDarkMode({bool value});

  // 初回起動か
  bool getFirstLaunch();
  void setFirstLaunch({bool value});

  // アンケートに答えたか
  bool getQuestionnaireAnswered();
  void setQuestionnaireAnswered({bool value});

  Future<AppInfo> getAppInfo();
}
