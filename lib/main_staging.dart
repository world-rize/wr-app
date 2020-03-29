// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/ui/app.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/store/env.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  // アプリ全体にストアを Provide する
  runApp(MultiProvider(
    providers: [
      // 環境変数
      Provider(
        create: (_) => EnvStore(flavor: Flavor.staging),
      ),
      // ユーザーデータ
      Provider(
        create: (_) => UserStore(),
      ),
      // マスターデータ
      Provider(
        create: (_) => MasterDataStore(),
      )
    ],
    child: WRApp(),
  ));
}
