// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/domain/system/index.dart';

/// テーマページ
class SettingsThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final system = Provider.of<SystemNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ダークモード'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'ダークモード',
            tiles: [
              SettingsTile.switchTile(
                switchValue: system.getFollowSystemTheme(),
                title: '端末の設定に従う',
                leading: const Icon(Icons.people),
                onToggle: (v) => system.setFollowSystemTheme(value: v),
              ),
              if (!system.getFollowSystemTheme())
                SettingsTile.switchTile(
                  switchValue: system.getDarkMode(),
                  title: 'ダークモード',
                  leading: const Icon(Icons.attach_money),
                  onToggle: (v) => system.setDarkMode(value: v),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
