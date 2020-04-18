// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';

// TODO(wakame-tech): アカウント情報と設定項目を考える
/// 設定ページ
class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  Widget _settingsView() {
    final userStore = Provider.of<UserStore>(context);
    final envStore = Provider.of<EnvStore>(context);

    return SettingsList(
      sections: [
        SettingsSection(
          title: 'アカウント',
          tiles: [
            SettingsTile(
              title: 'アカウント',
              subtitle: userStore.displayName(),
              leading: Icon(Icons.people),
              onTap: () {},
            ),
            SettingsTile(
              title: 'プラン',
              subtitle: 'ノーマル',
              leading: Icon(Icons.attach_money),
              onTap: () {},
            )
          ],
        ),
        SettingsSection(
          title: 'レッスン',
          tiles: [
            SettingsTile(
              title: '発音',
              subtitle: 'アメリカ',
              leading: Icon(Icons.speaker_notes),
              onTap: () {},
            ),
            SettingsTile(
              title: 'カードめくりの間隔',
              subtitle: '5秒',
              leading: Icon(Icons.speaker_notes),
              onTap: () {},
            )
          ],
        ),
        SettingsSection(
          title: 'その他',
          tiles: [
            SettingsTile(
              title: 'Flavor',
              subtitle: envStore.flavor.toShortString(),
            ),
            SettingsTile(
              title: 'バージョン',
              subtitle: envStore.version,
            ),
            SettingsTile(
              title: '開発者',
              subtitle: envStore.author,
              onTap: () {},
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: _settingsView(),
    );
  }
}
