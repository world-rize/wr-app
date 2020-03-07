// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/env.dart';
import 'package:wr_app/store/user.dart';

// TODO(wakame-tech): アカウント情報と設定項目を考える
/// 設定ページ
class MyPagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'アカウント',
          tiles: [
            SettingsTile(
              title: 'アカウント名',
              subtitle: 'ゲスト',
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
              title: 'バージョン',
              subtitle: Env.version,
            ),
            SettingsTile(
              title: 'クレジット',
              subtitle: 'ああああ',
              onTap: () {},
            )
          ],
        )
      ],
    );
  }
}
