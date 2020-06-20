// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/onboarding/widgets/rounded_button.dart';
import 'package:wr_app/ui/root_view.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _showPassword;
  String _email;
  String _password;

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

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _email = '';
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    final _formKey = GlobalKey<FormState>();

    final _emailField = Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        onSaved: (email) {
          setState(() {
            _email = email;
          });
        },
        validator: (text) {
          if (text.isEmpty) {
            return 'do not empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Email',
        ),
      ),
    );

    final _passwordField = Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        obscureText: !_showPassword,
        onSaved: (password) {
          setState(() {
            _password = password;
          });
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
    );

    final _signUpButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RoundedButton(
          text: 'Sign in',
          color: Colors.blueAccent,
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _signInEmailAndPassword();
            }
          },
        ),
      ),
    );

//    final _signInWithGoogleButton = Padding(
//      padding: const EdgeInsets.all(8),
//      child: SizedBox(
//        width: double.infinity,
//        child: RoundedButton(
//          onTap: _signInWithGoogle,
//          color: Colors.redAccent,
//          text: 'Sign in with Google',
//        ),
//      ),
//    );

    final _signInByTestUser = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RoundedButton(
          onTap: _signInTestUser,
          text: 'Sign in by Test User(Debug)',
          color: Colors.greenAccent,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashColor,
        title: Text('Signin'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Email
                _emailField,

                // Password
                _passwordField,
              ],
            ),
          ),

          const Spacer(),

          // Sign Up
          _signUpButton,

          Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),

          // Google Sign up
          // _signInWithGoogleButton,

          _signInByTestUser,
        ],
      ),
    );
  }
}
