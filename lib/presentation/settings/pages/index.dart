// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/on_boarding/pages/index.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/flavor.dart';

import './account_settings_page.dart';
import './api_test_page.dart';
import './dark_mode_page.dart';
import './inapp_log_page.dart';

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
    final pubSpec = GetIt.I<PackageInfo>();

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
          subtitle: pubSpec.version,
        ),
        SettingsTile(
          title: 'ライセンス',
          onTap: () {
            final pubSpec = GetIt.I<PackageInfo>();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => LicensePage(
                  applicationName: pubSpec.appName,
                  applicationVersion: pubSpec.version,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // debug menu
  SettingsSection debugSection() {
    return SettingsSection(
      title: 'Debug',
      tiles: [
        SettingsTile(
          title: 'Flutter Flavor',
          subtitle: Provider.of<SystemNotifier>(context).flavor.toShortString(),
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
              Provider.of<UserNotifier>(context).changePlan(Membership.pro);
            } else {
              Provider.of<UserNotifier>(context).changePlan(Membership.normal);
            }
          },
          switchValue: Provider.of<UserNotifier>(context).getUser().isPremium,
        ),
        SettingsTile.switchTile(
          title: 'Paint Size Enabled',
          onToggle: (value) {
            debugPaintSizeEnabled = value;
          },
          switchValue: debugPaintSizeEnabled,
        ),
        SettingsTile(
          title: 'notifier test',
          onTap: () {
            final pubSpec = GetIt.I<PackageInfo>();
            // ignore: cascade_invocations
            Provider.of<SystemNotifier>(context)
                .notify(title: pubSpec.appName, body: 'test', payload: 'ok');
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
