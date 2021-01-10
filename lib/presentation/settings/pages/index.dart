// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/on_boarding/pages/index.dart';
import 'package:wr_app/presentation/on_boarding/pages/tutorial_page.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/flavor.dart';

import './api_test_page.dart';
import './dark_mode_page.dart';
import './inapp_log_page.dart';

/// 設定ページ
class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  // general
  SettingsSection generalSection() {
    return SettingsSection(
      title: '一般',
      tiles: [
        SettingsTile(
          title: I.of(context).darkMode,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SettingsThemePage()));
          },
        ),
      ],
    );
  }

  // about
  SettingsSection aboutSection() {
    final pubSpec = GetIt.I<PackageInfo>();
    final env = GetIt.I<EnvKeys>();

    return SettingsSection(
      title: 'その他',
      tiles: [
        SettingsTile(
          title: I.of(context).homepage,
          onTap: () async {
            if (await canLaunch(env.homePageUrl)) {
              await launch(
                env.homePageUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: 'WorldRIZe Twitter',
          onTap: () async {
            if (await canLaunch(env.twitterUrl)) {
              await launch(
                env.twitterUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: 'WorldRIZe Instagram',
          onTap: () async {
            if (await canLaunch(env.instagramUrl)) {
              await launch(
                env.instagramUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: I.of(context).faq,
          onTap: () async {
            if (await canLaunch(env.faqUrl)) {
              await launch(
                env.faqUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: I.of(context).feedback,
          onTap: () async {
            if (await canLaunch(env.contactUrl)) {
              await launch(
                env.contactUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: I.of(context).termsOfService,
          onTap: () async {
            if (await canLaunch(env.termsOfServiceUrl)) {
              await launch(
                env.termsOfServiceUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
          title: I.of(context).privacyPolicy,
          onTap: () async {
            if (await canLaunch(env.privacyPolicyJaUrl)) {
              await launch(
                env.privacyPolicyJaUrl,
                forceSafariVC: false,
                forceWebView: false,
              );
            }
          },
        ),
        SettingsTile(
            title: '特商法に基づく表示',
            onTap: () async {
              if (await canLaunch(env.specifiedCommercialTransactionActUrl)) {
                await launch(
                  env.specifiedCommercialTransactionActUrl,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              }
            }),
        SettingsTile(
          title: I.of(context).appVersion,
          subtitle: pubSpec.version,
        ),
        SettingsTile(
          title: I.of(context).license,
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
          title: 'API Testing',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => APITestView()));
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
          title: I.of(context).topPage,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => OnBoardingPage()));
          },
        ),
        SettingsTile(
          title: 'Tutorial Page',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TutorialPage()));
          },
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
            Provider.of<SystemNotifier>(context, listen: false)
                .notify(title: pubSpec.appName, body: 'test', payload: 'ok');
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final systemNotifier = Provider.of<SystemNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).settings),
      ),
      body: SettingsList(
        sections: [
          generalSection(),
          aboutSection(),
          if (systemNotifier.flavor == Flavor.development) debugSection(),
        ],
      ),
    );
  }
}
