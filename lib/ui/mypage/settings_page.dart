// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';
import 'package:wr_app/ui/mypage/account_page.dart';
import 'package:wr_app/ui/mypage/all_phrases_page.dart';
import 'package:wr_app/ui/mypage/logger_view.dart';
import 'package:wr_app/ui/mypage/api_test_view.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/onboarding/index.dart';
import 'package:wr_app/build/flavor.dart';

/// 設定ページ
class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final masterData = Provider.of<MasterDataStore>(context);
    final userStore = Provider.of<UserStore>(context);
    final envStore = Provider.of<EnvStore>(context);

    return SettingsList(
      sections: [
        // about account
        SettingsSection(
          title: I.of(context).accountSection,
          tiles: [
            SettingsTile(
              title: 'アカウント',
              subtitle: userStore.displayName(),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AccountPage()));
              },
            ),
            SettingsTile(
              title: 'プラン',
              subtitle: I.of(context).memberStatus(Membership.premium),
              leading: Icon(Icons.attach_money),
              onTap: () {},
            ),
            SettingsTile(
              title: 'ポイント交換',
              leading: Icon(Icons.attach_money),
              onTap: () {},
            ),
          ],
        ),
        // about study
        SettingsSection(
          title: I.of(context).studySection,
          tiles: [
            SettingsTile(
              title: 'お気に入りフレーズ一覧',
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AllPhrasesPage(
                      filter: (phrase) =>
                          userStore.user.favorites.containsKey(phrase.id) &&
                          userStore.user.favorites[phrase.id],
                    ),
                  ),
                );
              },
            ),
            SettingsTile(
              title: '本日の残りテスト回数',
              subtitle: '${userStore.user.testLimitCount}',
              leading: Icon(Icons.access_time),
              onTap: () {},
            ),
          ],
        ),
        SettingsSection(
          title: I.of(context).otherSection,
          tiles: [
            SettingsTile(
              title: 'version',
              subtitle: envStore.version,
            ),
            SettingsTile(
              title: 'このアプリについて',
              onTap: () {},
            ),
            SettingsTile(
              title: '利用規約',
              onTap: () {},
            ),
            SettingsTile(
              title: 'サインアウト',
              onTap: () async {
                await userStore.signOut();
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => OnBoardModal()));
              },
            ),
          ],
        ),
        if (true)
          SettingsSection(
            title: 'Debug',
            tiles: [
              SettingsTile(
                title: 'Flavor',
                subtitle: envStore.flavor.toShortString(),
              ),
              SettingsTile(
                title: 'All Phrases',
                subtitle: '${masterData.allPhrases().length} Phrases',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AllPhrasesPage(
                            filter: (phrase) => true,
                          )));
                },
              ),
              SettingsTile(
                title: 'Application Log',
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => LoggerView()));
                },
              ),
              SettingsTile(
                title: 'API Testing',
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => APITestView()));
                },
              ),
              SettingsTile.switchTile(
                title: 'Paint Size Enabled',
                onToggle: (value) {
                  print(value);
                  debugPaintSizeEnabled = value;
                },
                switchValue: debugPaintSizeEnabled,
              )
            ],
          ),
      ],
    );
  }
}
