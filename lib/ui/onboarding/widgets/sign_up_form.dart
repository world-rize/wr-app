// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/common/toast.dart';
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
      NotifyToast.error(e);
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
      NotifyToast.error(e);
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

  Widget _buildButton({String text, Color color, Function onTap}) {
    return RaisedButton(
      onPressed: onTap,
      color: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(
          color: color,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _emailField = Padding(
      padding: const EdgeInsets.all(8),
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

    final _acceptTermsCheckbox = Container(
      child: CheckboxListTile(
        value: _agree,
        activeColor: Colors.blue,
        title: const Text('利用規約に同意します'),
        subtitle: !_agree
            ? const Text(
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
    );

    final _signUpButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: _buildButton(
          text: 'Sign up',
          color: Colors.blueAccent,
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _signUpEmailAndPassword();
            }
          },
        ),
      ),
    );

    final _signUpWithGoogleButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: _buildButton(
          text: 'Sign up with Google',
          color: Colors.redAccent,
          onTap: _signUpWithGoogle,
        ),
      ),
    );

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
            _emailField,

            // Password
            _passwordField,

            // Agree
            _acceptTermsCheckbox,

            // Sign Up
            _signUpButton,

            // Or
            const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text('または'),
              ),
            ),

            // Google Sign up
            _signUpWithGoogleButton,
          ],
        ),
      ),
    );
  }
}
