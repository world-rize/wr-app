// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:settings_ui/settings_ui.dart';

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
                leading: Icon(Icons.info),
                onTap: userStore.callTestAPI,
              ),
              SettingsTile(
                title: 'ユーザーを作成',
                leading: Icon(Icons.people),
                onTap: userStore.callCreateUser,
              ),
              SettingsTile(
                  title: 'お気に入りに登録',
                  leading: Icon(Icons.favorite),
                  onTap: () {
                    userStore.callFavoritePhrase(phraseId: '0001', value: true);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
