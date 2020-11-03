// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/system/model/app_info.dart';

abstract class SystemRepository {
  Future<void> notify({
    required String title,
    required String body,
    required String payload,
  });

  // テーマ: システムに従う
  bool getFollowSystemTheme();

  void setFollowSystemTheme({required bool value});

  // テーマ: ダークモード
  bool getDarkMode();

  void setSetDarkMode({required bool value});

  // 初回起動か
  bool getFirstLaunch();

  void setFirstLaunch({required bool value});

  // アンケートに答えたか
  bool getQuestionnaireAnswered();

  void setQuestionnaireAnswered({required bool value});

  Future<AppInfo> getAppInfo();
}
