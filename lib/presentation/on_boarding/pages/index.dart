// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/system/model/app_info.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

import './sign_in_page.dart';
import './sign_up_page.dart';

/// ファーストページ
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool _isAppAvailable;

  @override
  void initState() {
    super.initState();
    _isAppAvailable = false;
  }

  bool _isAvailable(AppInfo info) {
    return (Platform.isIOS && info.isIOsAppAvailable) ||
        (Platform.isAndroid && info.isAndroidAppAvailable);
  }

  Future _checkAppAvailable() async {
    final sn = Provider.of<SystemNotifier>(context);
    final appInfo = await sn.getAppInfo();

    if (_isAvailable(appInfo)) {
      setState(() {
        _isAppAvailable = true;
      });
      return;
    }

    await showDialog(
      context: context,
      child: const AlertDialog(
        title: Text('メンテナンス中'),
        content: Text('只今メンテナンス中です。'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const splashColor = Color(0xff56c0ea);

    _checkAppAvailable();

    final signUpField = Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text('初めての方はこちら'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RoundedButton(
              key: const Key('to_sign_up_button'),
              color: splashColor,
              text: '新しくアカウントを作成する',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SignUpPage(),
                ));
              },
            ),
          ),
        ],
      ),
    );

    final signInField = Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text('既にアカウントを持っている方はこちら'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RoundedButton(
              key: const Key('to_sign_in_button'),
              color: splashColor,
              text: 'ログイン',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SignInPage(),
                ));
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset('assets/icon/login.png'),
          Flexible(
            child: Container(
              color: theme.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  signUpField,
                  signInField,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
