// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/theme.dart';

class WRApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WRAppState();
}

class WRAppState extends State<WRApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: wrThemeData,
      home: RootView(),
    );
  }
}
