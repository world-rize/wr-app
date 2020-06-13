// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/user.dart';

class APITestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

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
                onTap: userStore.callTestAPI,
              ),
//              SettingsTile(
//                title: 'ユーザーを作成',
//                leading: Icon(Icons.people),
//                onTap: userStore.callCreateUser,
//              ),
              SettingsTile(
                title: 'ユーザーを取得',
                leading: const Icon(Icons.people),
                onTap: userStore.callReadUser,
              ),
              SettingsTile(
                title: 'お気に入りに登録',
                leading: const Icon(Icons.favorite),
                onTap: () {
                  userStore.callFavoritePhrase(phraseId: '0000', value: true);
                },
              ),
              SettingsTile(
                title: '1ポイントゲット',
                leading: const Icon(Icons.attach_money),
                onTap: () {
                  userStore.callGetPoint(point: 1);
                },
              ),
              SettingsTile(
                title: 'テストを受ける(未実装)',
                leading: const Icon(Icons.title),
                onTap: () {
                  userStore.callGetPoint(point: 1);
                },
              ),
              SettingsTile(
                title: '受講可能回数をリセット',
                leading: const Icon(Icons.access_alarm),
                onTap: userStore.resetTestLimitCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
