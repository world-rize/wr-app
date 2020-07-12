// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/preferences_notifier.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/ui/theme.dart';

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
    final preferences = Provider.of<PreferenceNotifier>(context);
    final themeMode = preferences.followSystemTheme
        ? ThemeMode.system
        : preferences.darkMode ? ThemeMode.dark : ThemeMode.light;

    return MaterialApp(
      theme: WorldRizeLightTheme,
      darkTheme: WorldRizeDarkTheme,
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
