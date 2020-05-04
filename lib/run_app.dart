// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/ui/app.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';

void runAppWithFlavor(final Flavor flavor) {
  Provider.debugCheckInvalidValueType = null;

  final analytics = FirebaseAnalytics();
  final observer = FirebaseAnalyticsObserver(analytics: analytics);

  // アプリ全体にストアを Provide する
  runApp(MultiProvider(
    providers: [
      // Firebase Analytics
      // TODO(someone): create Analytics Store
      Provider.value(value: analytics),
      Provider.value(value: observer),
      // 環境変数
      FutureProvider(
        create: (_) async {
          final store = EnvStore(flavor: flavor);
          await store.init();
          return store;
        },
      ),
      // ユーザーデータ
      ChangeNotifierProvider(
        create: (_) => UserStore(),
      ),
      // マスターデータ
      ChangeNotifierProvider(
        create: (_) => MasterDataStore(),
      )
    ],
    child: WRApp(),
  ));
}
