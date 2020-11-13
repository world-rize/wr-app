// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/lesson/notifier/lesson_notifier.dart';
import 'package:wr_app/presentation/lesson/widgets/challenge_achieved_dialog.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/util/logger.dart';

class APITestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final syn = context.watch<SystemNotifier>();
    final un = context.watch<UserNotifier>();
    final ln = context.watch<LessonNotifier>();

    _showResultDialog(BuildContext context, String title, [dynamic content]) {
      showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: Text(title),
          content: content != null ? Text(content.toString()) : null,
          actions: [
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('APIテスト'),
      ),
      body: SettingsList(
        sections: [
          // auth APIs
          SettingsSection(
            title: 'Auth',
            tiles: [
              SettingsTile(
                title: 'AppInfo',
                onTap: () async {
                  try {
                    final info = await syn.getAppInfo();
                    _showResultDialog(context, '成功', info.toJson());
                  } on Exception catch (e) {
                    InAppLogger.error(e);
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
            ],
          ),
          // user APIs
          SettingsSection(
            title: 'User',
            tiles: [
              SettingsTile(
                title: '10000ポイントゲット',
                onTap: () async {
                  try {
                    await un.callGetPoint(points: 10000);
                    _showResultDialog(context, '成功');
                  } on Exception catch (e) {
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
              SettingsTile.switchTile(
                switchValue: un.user.isPremium,
                title: 'プレミアムプラン',
                onToggle: (value) {
                  if (value) {
                    un.changePlan(Membership.pro);
                  } else {
                    un.changePlan(Membership.normal);
                  }
                },
              ),
            ],
          ),
          // lesson APIs
          SettingsSection(
            title: 'Lesson',
            tiles: [
              SettingsTile(
                title: 'New Coming Phrases',
                onTap: () async {
                  try {
                    final phrases = await ln.newComingPhrases();
                    _showResultDialog(
                        context, '成功', phrases.map((p) => p.toJson()));
                  } on Exception catch (e) {
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
              SettingsTile(
                title: 'お気に入りに登録',
                onTap: () async {
                  try {
                    await un.favoritePhrase(phraseId: '0000', favorite: true);
                    _showResultDialog(context, '成功');
                  } on Exception catch (e) {
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
              SettingsTile(
                title: 'テストを受ける',
                onTap: () async {
                  try {
                    await un.doTest(sectionId: 'debug');
                    _showResultDialog(context, '成功');
                  } on Exception catch (e) {
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
              SettingsTile(
                title: '受講可能回数をリセット',
                onTap: () async {
                  try {
                    await un.resetTestLimitCount();
                    _showResultDialog(context, '成功');
                  } on Exception catch (e) {
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
            ],
          ),
          // shop APIs
          SettingsSection(
            title: 'Shop',
            tiles: [
              SettingsTile(
                title: 'ショップアイテム',
                onTap: () async {
                  try {
                    final ss = GetIt.I<ShopService>();
                    final items = await ss.getShopItems();
                    _showResultDialog(
                        context, '成功', items.map((e) => e.toJson()));
                  } on Exception catch (e) {
                    _showResultDialog(context, 'エラー', e);
                  }
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Dialogs',
            tiles: [
              SettingsTile(
                title: '30 days challenge',
                onTap: () {
                  showDialog(
                      context: context, child: ChallengeAchievedDialog());
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'ErrorGenerate',
            tiles: [
              SettingsTile(
                title: 'raise sample error',
                onTap: () {
                  throw PlatformException(code: 'WTF_HAMADA');
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Text Firestore',
            tiles: [
              SettingsTile(
                title: 'read user date',
                onTap: () {
                  final firestore = FirebaseFirestore.instance;
                  final firebaseUser = FirebaseAuth.instance.currentUser;
                  firestore
                      .collection('users')
                      .doc(firebaseUser.uid)
                      .get()
                      .then((value) {
                    InAppLogger.debug('${value.data()}');
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
