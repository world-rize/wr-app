// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/index.dart';
import 'package:wr_app/ui/root_view.dart';

class OnBoardModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final logo = Image.asset(
      'assets/icon/wr_icon.jpg',
      fit: BoxFit.contain,
    );

    final buttons = <Widget>[
      MaterialButton(
        onPressed: () {
          userStore.signUpWithGoogle().then((_) {
            userStore.setFirstLaunch(flag: false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootView(),
              ),
            );
          }).catchError((e) {
            print(e);
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Sign up with Google',
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
      MaterialButton(
        onPressed: () {},
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
//                        fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: Colors.greenAccent,
        shape: const StadiumBorder(),
      ),
      MaterialButton(
        onPressed: () {
          // login
          // TODO(someone): ログイン画面を表示
          userStore.signInWithMock(email: 'a@b.com', password: '123456');
        },
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
    ];

    return Scaffold(
      body: Center(
        child: Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
