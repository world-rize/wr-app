// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/ui/app.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';

void runAppWithFlavor(final Flavor flavor) {
  Provider.debugCheckInvalidValueType = null;

  // アプリ全体にストアを Provide する
  runApp(MultiProvider(
    providers: [
      // 環境変数
      ChangeNotifierProvider(
        create: (_) => EnvStore(flavor: flavor),
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
