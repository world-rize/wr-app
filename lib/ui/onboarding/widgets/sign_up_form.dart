// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/root_view.dart';

class UserSignUpInfo {
  UserSignUpInfo({this.email, this.password});

  String email;
  String password;
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  Future<void> _signUpEmailAndPassword() async {
    print(_model);
    final userStore = Provider.of<UserStore>(context, listen: false);
    print('email: $_model.email password: $_model.password');

    try {
      await userStore
          .signInWithMock(email: _model.email, password: _model.password)
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
      userStore.errorToast(e);
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
      userStore.errorToast(e);
      return;
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _agree;
  bool _showPassword;
  UserSignUpInfo _model;

  @override
  void initState() {
    super.initState();
    _agree = false;
    _showPassword = false;
    _model = UserSignUpInfo(email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Email
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: (email) {
                  _model.email = email;
                },
                validator: (text) {
                  if (text.isEmpty) {
                    return 'do not empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),

            // Password
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: !_showPassword,
                onSaved: (password) {
                  _model.password = password;
                },
                validator: (text) {
                  if (text.isEmpty) {
                    return 'do not empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword
                          ? Icons.remove_circle_outline
                          : Icons.remove_red_eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),

            // Agree
            Container(
              child: CheckboxListTile(
                value: _agree,
                activeColor: Colors.blue,
                title: const Text('利用規約に同意します'),
                subtitle: !_agree
                    ? Text(
                        'required',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
                onChanged: (value) {
                  setState(() {
                    _agree = value;
                  });
                },
              ),
            ),

            // Sign Up
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _signUpEmailAndPassword();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  color: Colors.blueAccent,
                ),
              ),
            ),

            // Or
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('または'),
              ),
            ),

            // Google Sign up
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    _signUpWithGoogle();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign up with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
