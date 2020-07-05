// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/store/logger.dart';

/// アプリ内の設定等を保持
///
class PreferencesStore extends ChangeNotifier {
  /// シングルトンインスタンス
  static PreferencesStore _cache;

  factory PreferencesStore({
    @required SharedPreferences pref,
  }) {
    return _cache ??= PreferencesStore._internal(pref: pref);
  }

  PreferencesStore._internal({@required this.pref}) {
    InAppLogger.log('✨ init PreferencesStore');
  }

  /// Shared prefs
  SharedPreferences pref;

  bool get followSystemTheme => pref?.getBool('follow_system_theme') ?? false;

  void setFollowSystemMode(bool value) {
    pref.setBool('follow_system_theme', followSystemTheme);
    InAppLogger.log('follow_system_theme: $value');
  }

  bool get showTranslation => pref?.getBool('show_transition') ?? false;

  void toggleShowTranslation() {
    pref.setBool('show_transition', !showTranslation);
    InAppLogger.log('show_transition: ${!showTranslation}');
  }

  bool get showText => pref?.getBool('show_text') ?? true;

  void toggleShowText() {
    pref.setBool('show_text', showText);
    InAppLogger.log('show_text: ${!showText}');
  }

  bool get darkMode => pref?.getBool('dark_mode') ?? false;

  void setDarkMode(bool value) {
    pref.setBool('dark_mode', value);
    InAppLogger.log('dark_mode: $value');
  }

  /// 初回起動時か
  bool get firstLaunch => pref?.getBool('first_launch') ?? true;

  /// 初回起動時フラグをセットします
  void setFirstLaunch({bool flag}) {
    pref.setBool('first_launch', flag);
    InAppLogger.log('first_launch: $flag');
  }
}
