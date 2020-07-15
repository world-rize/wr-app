// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/util/logger.dart';

/// アプリ内の設定等を保持
///
class PreferenceNotifier extends ChangeNotifier {
  /// シングルトンインスタンス
  static PreferenceNotifier _cache;

  factory PreferenceNotifier({
    @required SharedPreferences pref,
  }) {
    return _cache ??= PreferenceNotifier._internal(pref: pref);
  }

  PreferenceNotifier._internal({@required this.pref}) {
    InAppLogger.log('✨ init PreferencesStore');
  }

  /// Shared prefs
  SharedPreferences pref;

  bool get followSystemTheme => pref?.getBool('follow_system_theme') ?? false;

  void setFollowSystemMode(bool value) {
    pref.setBool('follow_system_theme', followSystemTheme);
    notifyListeners();
    InAppLogger.log('follow_system_theme: $value');
  }

  bool showTranslation() => pref?.getBool('show_translation') ?? false;

  void toggleShowTranslation() {
    pref.setBool('show_translation', !showTranslation());
    notifyListeners();
    InAppLogger.log('show_translation: ${!showTranslation()}');
  }

  bool get showText => pref?.getBool('show_text') ?? true;

  void toggleShowText() {
    pref.setBool('show_text', !showText);
    notifyListeners();
    InAppLogger.log('show_text: ${!showText}');
  }

  bool get darkMode => pref?.getBool('dark_mode') ?? false;

  void setDarkMode(bool value) {
    pref.setBool('dark_mode', value);
    notifyListeners();
    InAppLogger.log('dark_mode: $value');
  }

  /// 初回起動時か
  bool get firstLaunch => pref?.getBool('first_launch') ?? true;

  /// 初回起動時フラグをセットします
  void setFirstLaunch({bool flag}) {
    pref.setBool('first_launch', flag);
    notifyListeners();
    InAppLogger.log('first_launch: $flag');
  }
}
