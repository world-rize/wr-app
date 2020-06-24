// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/store/env.dart';
import 'package:wr_app/store/logger.dart';
import 'package:wr_app/theme.dart';
import 'package:wr_app/ui/root_view.dart';

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
    final themeMode = envStore.followSystemTheme
        ? ThemeMode.system
        : envStore.darkMode ? ThemeMode.dark : ThemeMode.light;

    if (envStore?.env?.containsKey('ADMOB_APP_ID') ?? false) {
      FirebaseAdMob.instance.initialize(appId: envStore?.env['ADMOB_APP_ID']);
      InAppLogger.log('🔥 Admob Initialized');
    }

    return MaterialApp(
      theme: WorldRizeLightTheme,
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      navigatorObservers: <NavigatorObserver>[
        // route observer
        RouteObserver<PageRoute<dynamic>>(),
        observer,
      ],
      localizationsDelegates: const [
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
