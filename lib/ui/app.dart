// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/theme.dart';
import 'package:provider/provider.dart';

import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';

/// root widget
class WRApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WRAppState();
}

/// [WRApp] state
class WRAppState extends State<WRApp> {
  @override
  Widget build(BuildContext context) {
    // アプリ全体にストアを Provide する
    return MultiProvider(
      providers: [
        // ユーザーデータ
        Provider(
          create: (_) => UserStore(),
        ),
        // マスターデータ
        Provider(
          create: (_) => MasterDataStore(),
        )
      ],
      child: MaterialApp(
        theme: wrThemeData,
        home: RootView(),
      ),
    );
  }
}
