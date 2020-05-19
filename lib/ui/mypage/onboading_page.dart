// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/index.dart';
import 'package:wr_app/ui/root_view.dart';

class OnBoardModal extends StatefulWidget {
  @override
  _OnBoardModalState createState() => _OnBoardModalState();
}

class _OnBoardModalState extends State<OnBoardModal> {
  Future<void> _signUpWithGoogle() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    try {
      await userStore.signUpWithGoogle();

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

  Future<void> _signUpEmailAndPassword() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    try {
      // TODO
      await userStore
          .signInWithMock(email: 'a@b.com', password: 'hoge')
          .catchError(print);
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
      MaterialButton(
        onPressed: _signUpWithGoogle,
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
        onPressed: _signUpEmailAndPassword,
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
