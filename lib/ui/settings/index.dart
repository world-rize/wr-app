// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';
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
  // general section
  SettingsSection generalSection() {
    final userStore = Provider.of<UserStore>(context);

    return SettingsSection(
      title: I.of(context).accountSection,
      tiles: [
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
        SettingsTile(
          title: 'ダークモード',
          leading: Icon(Icons.attach_money),
          onTap: () {},
        ),
      ],
    );
  }

  // about
  SettingsSection aboutSection() {
    final userStore = Provider.of<UserStore>(context);
    final envStore = Provider.of<EnvStore>(context);

    return SettingsSection(
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
          title: 'よくある質問',
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
    );
  }

  // debug menu
  SettingsSection debugSection() {
    final envStore = Provider.of<EnvStore>(context);
    final masterData = Provider.of<MasterDataStore>(context);

    return SettingsSection(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        generalSection(),
        aboutSection(),
        if (true) debugSection(),
      ],
    );
  }
}
