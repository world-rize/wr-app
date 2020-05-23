// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/root_view.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
            onPressed: _signUpEmailAndPassword,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.blueAccent,
          ),
          RaisedButton(
            onPressed: _signUpWithGoogle,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Sign up with Google',
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
