// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/build/flavor.dart';
import 'package:wr_app/store/articles.dart';
import 'package:wr_app/store/logger.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/preferences.dart';
import 'package:wr_app/store/system.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/app.dart';

Future<void> runAppWithFlavor(final Flavor flavor) async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  // firebase analytics
  final analytics = FirebaseAnalytics();
  final analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

  // notification
  // final notifier = AppNotifier();

  // load env
  await DotEnv().load('.env/.env');
  final env = DotEnv().env;
  InAppLogger.log('📄 Load .env');

  // pub spec
  final pubSpec = await PackageInfo.fromPlatform();
  InAppLogger.log('📄 Load pubspec.yml');
  InAppLogger.log('\t${pubSpec.appName} ${pubSpec.version}');

  // shared preferences
  final pref = await SharedPreferences.getInstance();

  // contentful client

  final client = Client(env['CONTENTFUL_SPACE_ID'], env['CONTENTFUL_TOKEN']);

  // アプリ全体にストアを Provide する
  runApp(MultiProvider(
    providers: [
      // Firebase Analytics
      // TODO(someone): create Analytics Store
      Provider.value(value: analytics),
      Provider.value(value: analyticsObserver),
      // 通知
      // Provider.value(value: notifier),
      // 環境変数
      Provider.value(
        value: SystemStore(flavor: flavor, pubSpec: pubSpec, env: env),
      ),
      // ユーザーデータ
      ChangeNotifierProvider.value(value: UserStore()),
      // マスターデータ
      ChangeNotifierProvider.value(value: MasterDataStore()),
      // 設定
      ChangeNotifierProvider.value(value: PreferencesStore(pref: pref)),
      // Article
      ChangeNotifierProvider.value(value: ArticleStore(client: client)),
    ],
    child: WRApp(),
  ));
}
