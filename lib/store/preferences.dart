// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/store/logger.dart';

/// アプリ内の設定等を保持
///
class PreferencesStore extends ChangeNotifier {
  /// シングルトンインスタンス
  static PreferencesStore _cache;

  factory PreferencesStore() {
    return _cache ??= PreferencesStore._internal();
  }

  PreferencesStore._internal() {
    init();
  }

  /// Shared prefs
  SharedPreferences _prefs;

  /// 初期化
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();

    InAppLogger.log('✨ init PreferencesStore');
  }

  bool get followSystemTheme => _prefs?.getBool('follow_system_theme') ?? false;

  void setFollowSystemMode(bool value) {
    _prefs.setBool('follow_system_theme', followSystemTheme);
    notifyListeners();
  }

  bool get showTranslation => _prefs?.getBool('show_transition') ?? false;

  void toggleShowTranslation() {
    _prefs.setBool('show_transition', showTranslation);
    notifyListeners();
  }

  bool get showText => _prefs?.getBool('show_text') ?? true;

  void toggleShowText() {
    _prefs.setBool('show_text', showText);
    notifyListeners();
  }

  bool get darkMode => _prefs?.getBool('dark_mode') ?? false;

  void setDarkMode(bool value) {
    _prefs.setBool('dark_mode', value);
    notifyListeners();
  }

  /// 初回起動時か
  bool get firstLaunch => _prefs?.getBool('first_launch') ?? true;

  /// 初回起動時フラグをセットします
  void setFirstLaunch({bool flag}) {
    _prefs.setBool('first_launch', flag);
  }
}
