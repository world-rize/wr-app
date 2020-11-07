// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/util/analytics.dart';

/// 発音選択ページ
class LocaleChoicePage extends StatefulWidget {
  @override
  _LocaleChoicePageState createState() => _LocaleChoicePageState();
}

class _LocaleChoicePageState extends State<LocaleChoicePage> {
  void _gotoHome() {
    Provider.of<SystemNotifier>(context, listen: false)
        // initial login
        .setFirstLaunch(value: false);

    sendEvent(event: AnalyticsEvent.logIn);

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('発音の選択'),
      ),
      body: Column(
        children: [
          Text('local_choice_page'),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              color: Colors.green,
              child: Text('WR英会話を始める'),
              onPressed: _gotoHome,
            ),
          ),
        ],
      ),
    );
  }
}
