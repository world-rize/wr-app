// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

import './sign_in_page.dart';
import './sign_up_page.dart';

/// ファーストページ
class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const splashColor = Color(0xff56c0ea);

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
            child: FlatButton(
              color: splashColor,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '新しくアカウントを作成する',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              onPressed: () {
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
            child: FlatButton(
              color: splashColor,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'ログイン',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SignInPage(),
                ));
              },
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}
