// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
//import 'package:wr_app/ui/onboarding_page.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/theme.dart';
import 'package:wr_app/i10n/i10n.dart';

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

    return MaterialApp(
      theme: wrThemeData,
      navigatorObservers: <NavigatorObserver>[observer],
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
