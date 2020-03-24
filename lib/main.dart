// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/ui/app.dart';
import 'package:wr_app/flavor.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(FlavorProvider(
    flavor: Flavor.production,
    child: WRApp(),
  ));
}
