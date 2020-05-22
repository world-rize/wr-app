// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/common/text_field.dart';
import 'package:wr_app/ui/root_view.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _email;
  String _password;

  @override
  initState() {
    super.initState();
    _email = '';
    _password = '';
  }

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
    final fields = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: wrTextField(
            onChanged: (text) {
              setState(() {
                _email = text;
              });
            },
            hintText: 'Email',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: wrTextField(
            onChanged: (text) {
              setState(() {
                _password = text;
              });
            },
            hintText: 'Password',
          ),
        ),
      ],
    );
    final buttons = Column(
      children: <Widget>[
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
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: logo,
        ),
        // Form
        fields,
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: buttons,
        ),
      ],
    );
  }
}
