// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/domain/user/user_notifier.dart';

class APITestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<UserNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('APIテスト'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'API',
            tiles: [
              SettingsTile(
                title: 'テスト',
                leading: const Icon(Icons.info),
                onTap: notifier.test,
              ),
              SettingsTile(
                title: 'お気に入りに登録',
                leading: const Icon(Icons.favorite),
                onTap: () {
                  notifier.favoritePhrase(phraseId: '0000', value: true);
                },
              ),
              SettingsTile(
                title: '1ポイントゲット',
                leading: const Icon(Icons.attach_money),
                onTap: () {
                  notifier.callGetPoint(point: 1);
                },
              ),
              SettingsTile(
                title: 'テストを受ける(未実装)',
                leading: const Icon(Icons.title),
                onTap: notifier.doTest,
              ),
              SettingsTile(
                title: '受講可能回数をリセット',
                leading: const Icon(Icons.access_alarm),
                onTap: notifier.resetTestLimitCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
