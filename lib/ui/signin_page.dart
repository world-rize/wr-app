// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/common/enter_exit_route.dart';
import 'package:wr_app/ui/mypage/onboading_page.dart';
import 'package:wr_app/ui/root_view.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<void> _signInWithGoogle() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    try {
      await userStore.signInWithGoogle();

      userStore.setFirstLaunch(flag: false);

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootView(),
        ),
      );
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  Future<void> _signInTestUser() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    try {
      await userStore.signIn(email: 'a@b.com', password: '123456');

      userStore.setFirstLaunch(flag: false);

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootView(),
        ),
      );
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/icon/wr_icon.jpg',
      fit: BoxFit.contain,
    );

    final buttons = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: FlatButton(
          onPressed: _signInWithGoogle,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
//                        fontWeight: FontWeight.bold,
              ),
            ),
          ),
          color: Colors.redAccent,
          shape: const StadiumBorder(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: FlatButton(
          onPressed: _signInTestUser,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Sign in with Test User',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent,
              ),
            ),
          ),
          color: Colors.greenAccent,
          shape: const StadiumBorder(),
        ),
      ),
    ];

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: logo,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: buttons,
                      ),
                    ),
                    InkWell(
                      child: const Text('Sign up'),
                      onTap: () {
                        Navigator.of(context).push(EnterExitRoute(
                          exitPage: widget,
                          enterPage: OnBoardModal(),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
