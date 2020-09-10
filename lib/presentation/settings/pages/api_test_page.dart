// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/toast.dart';

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
                onTap: () async {
                  await notifier.test().catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: 'お気に入りに登録',
                leading: const Icon(Icons.favorite),
                onTap: () async {
                  await notifier
                      .favoritePhrase(phraseId: '0000', favorite: true)
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: '10000ポイントゲット',
                leading: const Icon(Icons.attach_money),
                onTap: () async {
                  await notifier
                      .callGetPoint(points: 10000)
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: 'テストを受ける(未実装)',
                leading: const Icon(Icons.title),
                onTap: () async {
                  await notifier
                      .doTest(sectionId: 'debug')
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: '受講可能回数をリセット',
                leading: const Icon(Icons.access_alarm),
                onTap: () async {
                  await notifier
                      .resetTestLimitCount()
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
