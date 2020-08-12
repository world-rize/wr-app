// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/extensions.dart';

class SignInForm extends StatefulWidget {
  SignInForm({@required this.onSubmit, @required this.onSuccess});

  Function onSubmit;

  Function onSuccess;

  @override
  _SignInFormState createState() =>
      _SignInFormState(onSubmit: onSubmit, onSuccess: onSuccess);
}

class _SignInFormState extends State<SignInForm> {
  _SignInFormState({@required this.onSubmit, @required this.onSuccess});

  Function onSubmit;

  Function onSuccess;

  bool _showPassword;

  String _email;

  String _password;

  final _formKey = GlobalKey<FormState>();

  bool _isValid() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    onSubmit();
    await Provider.of<UserNotifier>(context, listen: false)
        .loginWithEmailAndPassword(_email, _password);
    onSuccess();
  }

  Future<void> _signInByTestUser() async {
    onSubmit();
    await Provider.of<UserNotifier>(context, listen: false)
        .loginWithEmailAndPassword('a@b.com', '123456');
    onSuccess();
  }

  Future<void> _signInWithGoogle() async {
    onSubmit();
    await Provider.of<UserNotifier>(context, listen: false).loginWithGoogle();
    onSuccess();
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

    final _emailField = TextFormField(
      onChanged: (email) {
        setState(() => _email = email);
      },
      validator: (text) {
        if (text.isEmpty) {
          return 'do not empty';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: 'Email',
      ),
    );

    final _passwordField = TextFormField(
      obscureText: !_showPassword,
      onChanged: (password) {
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
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.remove_circle_outline : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
        hintText: 'Password',
      ),
    );

    final _signInButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: 'Sign in',
          color: splashColor,
          onTap: !_isValid() ? null : _signIn,
        ),
      ),
    );

    final _signInWithGoogleButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: 'Googleでログイン',
          color: Colors.redAccent,
          onTap: () {
            _signInWithGoogle();
          },
        ),
      ),
    );

    final _signInByTestUserButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          onTap: _signInByTestUser,
          text: 'Sign in by Test User(Debug)',
          color: Colors.grey,
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Email
          Padding(
            padding: const EdgeInsets.all(8),
            child: _emailField,
          ),

          // Password
          Padding(
            padding: const EdgeInsets.all(8),
            child: _passwordField,
          ),

          // Sign Up
          _signInButton.p_1(),

          const Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),

          // Google Sign in
          _signInWithGoogleButton,

          _signInByTestUserButton.p_1(),
        ],
      ),
    );
  }
}
