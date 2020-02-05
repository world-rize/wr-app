// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/ui/app.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(WRApp());
}
