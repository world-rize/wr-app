// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

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
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(I.of(context).signUpMessage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RoundedButton(
              key: const Key('to_sign_up_button'),
              color: splashColor,
              text: I.of(context).signUpButton,
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
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(I.of(context).signInMessage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RoundedButton(
              key: const Key('to_sign_in_button'),
              color: splashColor,
              text: I.of(context).signInButton,
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
