// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/ui/theme.dart';

/// App Root
class WRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const locales = [
      Locale('ja'),
      Locale('en'),
    ];
    final sn = context.watch<SystemNotifier>();
    final observer = GetIt.I<FirebaseAnalyticsObserver>();

    return MaterialApp(
      theme: WorldRizeLightTheme,
      darkTheme: WorldRizeDarkTheme,
      themeMode: sn.getThemeMode(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[
        observer,
        // route observer
        RouteObserver<PageRoute<dynamic>>(),
      ],
      localizationsDelegates: const [
        I.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: locales,
      home: RootView(),
    );
  }
}
