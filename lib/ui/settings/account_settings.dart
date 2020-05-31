// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/user.dart';

/// 設定ページ
class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  // account section
  SettingsSection accountSection() {
    final userStore = Provider.of<UserStore>(context);

    return SettingsSection(
      title: '基本情報',
      tiles: [
        SettingsTile(
          title: 'メールアドレス',
          subtitle: userStore.user.email,
          leading: const Icon(Icons.people),
          onTap: () {
            // TODO(high): Email form
          },
        ),
        SettingsTile(
          title: 'ユーザーID',
          subtitle: userStore.user.userId,
          leading: const Icon(Icons.attach_money),
          onTap: () {
            // TODO(high): user ID form
          },
        ),
        SettingsTile(
          title: '年代',
          subtitle: '${userStore.user.age} 代',
          leading: const Icon(Icons.attach_money),
          onTap: () {
            // TODO(high): user ID form
          },
        ),
        SettingsTile(
          title: 'パスワード変更',
          leading: const Icon(Icons.attach_money),
          onTap: () {
            // TODO(high): form
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
      ),
      body: SettingsList(
        sections: [
          accountSection(),
        ],
      ),
    );
  }
}
