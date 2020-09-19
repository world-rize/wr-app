// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/shop_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/toast.dart';

class APITestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final an = context.watch<AuthNotifier>();
    final un = context.watch<UserNotifier>();
    final ln = context.watch<LessonNotifier>();
    final nn = context.watch<NoteNotifier>();
    final sn = context.watch<ShopNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('APIテスト'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Auth',
            tiles: [
              SettingsTile(
                title: 'お気に入りに登録',
                onTap: () async {
                  await un
                      .favoritePhrase(phraseId: '0000', favorite: true)
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'User',
            tiles: [
              SettingsTile(
                title: 'お気に入りに登録',
                onTap: () async {
                  await un
                      .favoritePhrase(phraseId: '0000', favorite: true)
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: '10000ポイントゲット',
                onTap: () async {
                  await un
                      .callGetPoint(points: 10000)
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: 'テストを受ける',
                leading: const Icon(Icons.title),
                onTap: () async {
                  await un
                      .doTest(sectionId: 'debug')
                      .catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile(
                title: '受講可能回数をリセット',
                onTap: () async {
                  await un.resetTestLimitCount().catchError(NotifyToast.error);
                  NotifyToast.success('成功');
                },
              ),
              SettingsTile.switchTile(
                title: 'プレミアムプラン',
                onToggle: (value) {
                  if (value) {
                    un.changePlan(Membership.pro);
                  } else {
                    un.changePlan(Membership.normal);
                  }
                },
                switchValue: un.user.isPremium,
              ),
            ],
          ),
          SettingsSection(
            title: 'Lesson',
            tiles: [
              SettingsTile(
                title: 'お気に入りに登録',
                onTap: () async {
                  await un
                      .favoritePhrase(phraseId: '0000', favorite: true)
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
