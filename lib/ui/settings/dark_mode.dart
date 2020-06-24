// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/env.dart';

/// 設定ページ
class ThemeSettingsPage extends StatefulWidget {
  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  // account section
  SettingsSection darkModeSection() {
    final envStore = Provider.of<EnvStore>(context);

    return SettingsSection(
      title: 'ダークモード',
      tiles: [
        SettingsTile.switchTile(
          switchValue: envStore.followSystemTheme,
          title: '端末の設定に従う',
          leading: const Icon(Icons.people),
          onToggle: envStore.setFollowSystemMode,
        ),
        if (!envStore.followSystemTheme)
          SettingsTile.switchTile(
            switchValue: envStore.darkMode,
            title: 'ダークモード',
            leading: const Icon(Icons.attach_money),
            onToggle: envStore.setDarkMode,
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
