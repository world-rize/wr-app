// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/ui/app.dart';
import 'package:wr_app/env.dart';
import 'package:wr_app/flavor.dart';
import 'package:wr_app/build_mode.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  print('${Env.appName} $buildMode ${Env.version}');

  runApp(FlavorProvider(
    flavor: Flavor.development,
    child: WRApp(),
  ));
}
