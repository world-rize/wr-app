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
    return CupertinoApp(
      theme: wrThemeData,
      home: RootView(),
    );
  }
}
