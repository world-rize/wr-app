// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/common/text_field.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/ui/onboarding/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _email;
  String _password;

  @override
  initState() {
    super.initState();
    _email = '';
    _password = '';
  }

  Future<void> _signUpEmailAndPassword() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    print('email: $_email password: $_password');
    try {
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
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: FlatButton(
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
            color: Colors.blueAccent,
            shape: const StadiumBorder(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: FlatButton(
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
