// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/domain/user/preferences_notifier.dart';

/// 設定ページ
class ThemeSettingsPage extends StatefulWidget {
  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  // account section
  SettingsSection darkModeSection() {
    final preferences = Provider.of<PreferenceNotifier>(context);

    return SettingsSection(
      title: 'ダークモード',
      tiles: [
        SettingsTile.switchTile(
          switchValue: preferences.followSystemTheme,
          title: '端末の設定に従う',
          leading: const Icon(Icons.people),
          onToggle: preferences.setFollowSystemMode,
        ),
        if (!preferences.followSystemTheme)
          SettingsTile.switchTile(
            switchValue: preferences.darkMode,
            title: 'ダークモード',
            leading: const Icon(Icons.attach_money),
            onToggle: preferences.setDarkMode,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ダークモード'),
      ),
      body: SettingsList(
        sections: [
          darkModeSection(),
        ],
      ),
    );
  }
}
