// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/store/user.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final userStore = Provider.of<UserStore>(context);
    final user = userStore.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(I.of(context).accountPageTitle),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'ユーザー',
            tiles: [
              SettingsTile(
                title: '名前',
                subtitle: user.name,
                leading: Icon(Icons.attach_money),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
