// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';
import 'package:wr_app/ui/onboarding_page.dart';
import 'package:wr_app/ui/mypage/logger_view.dart';
import 'package:wr_app/ui/mypage/api_test_view.dart';

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
            ),
            SettingsTile(
              title: 'ポイント交換',
              leading: Icon(Icons.attach_money),
              onTap: () {},
            ),
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
            ),
            SettingsTile(
              title: 'このアプリについて',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => OnBoardingPage()));
              },
            )
          ],
        ),
        if (envStore.flavor != Flavor.production)
          SettingsSection(
            title: 'デバッグ',
            tiles: [
              SettingsTile(
                title: 'ログ',
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => LoggerView()));
                },
              ),
              SettingsTile(
                title: 'API',
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => APITestView()));
                },
              ),
              SettingsTile.switchTile(
                title: 'Paint Size Enabled',
                onToggle: (value) {
                  print(value);
                  debugPaintSizeEnabled = value;
                },
                switchValue: debugPaintSizeEnabled,
              )
            ],
          ),
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
