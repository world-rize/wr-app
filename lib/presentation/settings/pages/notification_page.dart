// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

/// 通知ページ
class SettingsNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: '通知',
            tiles: [
              SettingsTile.switchTile(
                switchValue: false,
                title: 'テスト受講可能',
                leading: const Icon(Icons.people),
                onToggle: (v) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
