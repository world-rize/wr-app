// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';

/// テーマページ
class SettingsThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final system = Provider.of<SystemNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).darkMode),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: I.of(context).darkMode,
            tiles: [
              SettingsTile.switchTile(
                switchValue: system.getFollowSystemTheme(),
                title: '端末の設定に従う',
                onToggle: (v) => system.setFollowSystemTheme(value: v),
              ),
              if (!system.getFollowSystemTheme())
                SettingsTile.switchTile(
                  switchValue: system.getDarkMode(),
                  title: I.of(context).darkMode,
                  onToggle: (v) => system.setDarkMode(value: v),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
