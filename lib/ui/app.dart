// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:wr_app/ui/onboarding_page.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/theme.dart';

/// root widget
class WRApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WRAppState();
}

/// [WRApp] state
class WRAppState extends State<WRApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: wrThemeData,
      home: RootView(),
    );
  }
}
