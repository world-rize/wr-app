// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/onboarding/widgets/sign_up_form.dart';
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

  UserSignUpInfo _model;
  bool _accept;
  bool _showPassword;

  @override
  void initState() {
    super.initState();
    _model = UserSignUpInfo(email: '', password: '');
    _accept = false;
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final email = Padding(
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
    );

    final password = Padding(
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
    );

    final signUpButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _signInEmailAndPassword();
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );

    final signInWithGoogleButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: () {
            _signInWithGoogle();
          },
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          color: Colors.redAccent,
        ),
      ),
    );

    final signInByTestUser = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: () {
            _signInTestUser();
          },
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Sign in by Test User(Debug)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          color: Colors.greenAccent,
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            email,
            password,
            signUpButton,

            // Or
            const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text('または'),
              ),
            ),

            // Sign in google
            signInWithGoogleButton,

            // Sign in by Test User(Debug)
            signInByTestUser,
          ],
        ),
      ),
    );
  }
}
