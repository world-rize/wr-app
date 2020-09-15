// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/presentation/user_notifier.dart';

import './account_settings/mail_address_form_page.dart';
import './account_settings/password_form_page.dart';

/// 設定ページ
class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  // account section
  SettingsSection accountSection() {
    final userStore = Provider.of<UserNotifier>(context);
    final user = userStore.user;

    return SettingsSection(
      title: '基本情報',
      tiles: [
        SettingsTile(
          title: '名前',
          subtitle: user.name,
          leading: const Icon(Icons.people),
          onTap: () {
            // TODO
          },
        ),
        SettingsTile(
          title: 'メールアドレス',
          subtitle: user.attributes.email,
          leading: const Icon(Icons.people),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MailAddressFormPage()));
          },
        ),
        SettingsTile(
          title: 'ユーザーID',
          subtitle: user.userId,
          leading: const Icon(Icons.attach_money),
        ),
        SettingsTile(
          title: '年代',
          subtitle: '${user.attributes.age} 代',
          leading: const Icon(Icons.attach_money),
          onTap: () {
            // TODO(high): user ID form
          },
        ),
        SettingsTile(
          title: 'パスワード変更',
          leading: const Icon(Icons.attach_money),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PasswordFormPage()));
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
