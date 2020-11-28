// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/index.dart';
import 'package:wr_app/presentation/settings/pages/account_settings/name_form_page.dart';
import 'package:wr_app/presentation/user_notifier.dart';

import './account_settings/mail_address_form_page.dart';
import './account_settings/password_form_page.dart';

/// 設定ページ
class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  void _showSignOutConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ログアウトする'),
        content: const Text('本当にログアウトしますか？'),
        actions: [
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.pop(context);
              final an = context.read<AuthNotifier>();
              await an.signOut();
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => OnBoardingPage()));
            },
          )
        ],
      ),
    );
  }

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
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NameFormPage()));
          },
        ),
        SettingsTile(
          title: 'メールアドレス',
          subtitle: user.email,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MailAddressFormPage()));
          },
        ),
        SettingsTile(
          title: 'ユーザーID',
          subtitle: user.userId,
        ),
//        SettingsTile(
//          title: '年代',
//          subtitle: '${user.attributes.age} 代',
//          leading: const Icon(Icons.attach_money),
//          onTap: () {
//            // TODO: setAgeForm
//          },
//        ),
        SettingsTile(
          title: 'パスワード変更',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PasswordFormPage()));
          },
        ),
        SettingsTile(
          title: 'サインアウト',
          onTap: () async {
            _showSignOutConfirmDialog();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final un = context.watch<UserNotifier>();

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
