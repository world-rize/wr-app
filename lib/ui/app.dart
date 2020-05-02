// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/env.dart';
//import 'package:wr_app/ui/onboarding_page.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/theme.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:firebase_admob/firebase_admob.dart';

/// root widget
class WRApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WRAppState();
}

/// [WRApp] state
class WRAppState extends State<WRApp> {
  @override
  Widget build(BuildContext context) {
    final observer = Provider.of<FirebaseAnalyticsObserver>(context);
    final envStore = Provider.of<EnvStore>(context);

    if (envStore?.env?.containsKey('ADMOB_APP_ID') ?? false) {
      FirebaseAdMob.instance.initialize(appId: envStore?.env['ADMOB_APP_ID']);
      dev.log('🔥 Admob Initialized');
    }

    return MaterialApp(
      theme: wrThemeData,
      navigatorObservers: <NavigatorObserver>[
        // route observer
        RouteObserver<PageRoute<dynamic>>(),
        observer,
      ],
      localizationsDelegates: [
        I.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],
      home: RootView(),
    );
  }
}
