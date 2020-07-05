// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/onboarding/sign_in_page.dart';
import 'package:wr_app/ui/onboarding/sign_up_page.dart';

/// ファーストページ
class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    final signUpField = Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          const Center(
            child: Text('初めての方はこちら'),
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
          const Center(
            child: Text('既にアカウントを持っている方はこちら'),
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

    return Scaffold(
      body: Container(
        color: splashColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset('assets/icon/top.jpg'),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    const Spacer(),
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
