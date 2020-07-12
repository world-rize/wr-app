// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/domain/system/system_notifier.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/user_notifier.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/onboarding/pages/index.dart';
import 'package:wr_app/ui/settings/pages/account_settings_page.dart';
import 'package:wr_app/ui/settings/pages/all_phrases_page.dart';
import 'package:wr_app/ui/settings/pages/api_test_page.dart';
import 'package:wr_app/ui/settings/pages/dark_mode_page.dart';
import 'package:wr_app/ui/settings/pages/inapp_log_page.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/notification.dart';

/// 設定ページ
class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  // account section
  SettingsSection accountSection() {
    final userStore = Provider.of<UserNotifier>(context);

    return SettingsSection(
      title: I.of(context).accountSection,
      tiles: [
        SettingsTile(
          title: 'アカウント設定',
          leading: const Icon(Icons.people),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AccountSettingsPage()));
          },
        ),
        SettingsTile(
          title: 'サインアウト',
          leading: const Icon(Icons.attach_file),
          onTap: () async {
            await userStore.signOut();
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => OnBoardingPage()));
          },
        ),
      ],
    );
  }

  // notification
  SettingsSection notificationSection() {
    return SettingsSection(
      title: '通知',
      tiles: [
        SettingsTile.switchTile(
          switchValue: false,
          title: '通知',
          leading: const Icon(Icons.notifications),
          onToggle: (value) {},
        )
      ],
    );
  }

  // general
  SettingsSection generalSection() {
    return SettingsSection(
      title: '一般',
      tiles: [
        SettingsTile(
          title: 'ダークモード',
          leading: const Icon(Icons.attach_money),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ThemeSettingsPage()));
          },
        ),
        SettingsTile(
          title: 'フィードバック',
          leading: const Icon(Icons.attach_money),
          onTap: () {
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (_) => RequestPage()));
          },
        ),
      ],
    );
  }

  // about
  SettingsSection aboutSection() {
    final system = Provider.of<SystemNotifier>(context);

    return SettingsSection(
      title: I.of(context).otherSection,
      tiles: [
        SettingsTile(
          title: 'WorldRIZeホームページ',
          onTap: () async {
            const url = 'https://world-rize.com';
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: 'よくある質問',
          onTap: () async {
            const url = 'https://world-rize.com';
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: '利用規約',
          onTap: () async {
            const url = 'https://world-rize.com';
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: 'プライバシーポリシー',
          onTap: () async {
            const url = 'https://world-rize.com';
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: 'アプリバージョン',
          subtitle: system.pubSpec.version,
        ),
      ],
    );
  }

  // debug menu
  SettingsSection debugSection() {
    final userStore = Provider.of<UserNotifier>(context);
    final envStore = Provider.of<SystemNotifier>(context);
    final notifier = Provider.of<LessonNotifier>(context);

    return SettingsSection(
      title: 'Debug',
      tiles: [
        SettingsTile(
          title: 'Flutter Flavor',
          subtitle: envStore.flavor.toShortString(),
        ),
        SettingsTile(
          title: 'All Phrases',
          subtitle: '${notifier.phrases.length} Phrases',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AllPhrasesPage(
                      filter: (phrase) => true,
                    )));
          },
        ),
        SettingsTile(
          title: 'InApp Log',
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
          title: 'プレミアムプラン',
          onToggle: (value) {
            if (value) {
              userStore.changePlan(Membership.pro);
            } else {
              userStore.changePlan(Membership.normal);
            }
          },
          switchValue: userStore.user.membership == Membership.pro,
        ),
        SettingsTile.switchTile(
          title: 'Paint Size Enabled',
          onToggle: (value) {
            print(value);
            debugPaintSizeEnabled = value;
          },
          switchValue: debugPaintSizeEnabled,
        ),
        SettingsTile(
          title: 'notifier test',
          onTap: () {
            Provider.of<AppNotifier>(context, listen: false)
              ..showNotification(
                  title: 'WorldRIZe',
                  body: 'notifier test',
                  payload: 'success');
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SettingsList(
        sections: [
          accountSection(),
          generalSection(),
          notificationSection(),
          aboutSection(),
          if (true) debugSection(),
        ],
      ),
    );
  }
}
