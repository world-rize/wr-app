// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

import './sign_in_page.dart';
import './sign_up_page.dart';

/// ファーストページ
class OnBoardingPage extends StatelessWidget {
  // 自動でサインイン
  Future<void> _autoSignIn(BuildContext context) async {
    try {
      final un = Provider.of<UserNotifier>(context, listen: false);
      final isAlreadySignIn = await un.isAlreadySignedIn();

      if (isAlreadySignIn) {
        await sendEvent(event: AnalyticsEvent.logIn);
        await un.login();

        Navigator.popUntil(context, (route) => route.isFirst);
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootView(),
          ),
        );
      }
    } on Exception catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const splashColor = Color(0xff56c0ea);
    _autoSignIn(context);

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
