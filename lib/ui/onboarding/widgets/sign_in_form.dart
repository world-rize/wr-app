// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/root_view.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  Future<void> _signInEmailAndPassword() async {
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

  String _email;
  String _password;
  bool _accept;

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
    _accept = false;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            autovalidate: false,
            onChanged: (text) {
              setState(() {
                _password = text;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Email',
            ),
          ),
          TextFormField(
            onChanged: (text) {
              setState(() {
                _password = text;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Password',
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: CheckboxListTile(
              value: _accept,
              activeColor: Colors.blue,
              title: const Text('利用規約に同意します'),
              subtitle: InkWell(
                child: const Text('利用規約'),
                onTap: () {},
              ),
              onChanged: (value) {
                setState(() {
                  _accept = value;
                });
              },
            ),
          ),
          RaisedButton(
            onPressed: _signInEmailAndPassword,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.blueAccent,
          ),
          RaisedButton(
            onPressed: _signInWithGoogle,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.blueAccent,
          ),
          RaisedButton(
            onPressed: _signInTestUser,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Sign in with test user',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
