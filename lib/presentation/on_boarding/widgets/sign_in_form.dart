// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart' as siwa;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/apple_signin.dart';
import 'package:wr_app/util/extensions.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    @required this.onSignInWithEmailAndPassword,
    @required this.onSignInWithApple,
    @required this.onSignInWithGoogle,
  });

  final Function(String, String) onSignInWithEmailAndPassword;
  final Function onSignInWithGoogle;
  final Function onSignInWithApple;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _showPassword;
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();

  bool _isValid() {
    return _email.isNotEmpty && _password.isNotEmpty;
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
    final appleSignInAvailable = GetIt.I<AppleSignInAvailable>();

    final _emailField = TextFormField(
      key: const Key('sign_in_form_email'),
      keyboardType: TextInputType.emailAddress,
      onChanged: (email) {
        setState(() => _email = email);
      },
      validator: (text) {
        if (text.isEmpty) {
          return I.of(context).doNotEmptyMessage;
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
      key: const Key('sign_in_form_password'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_showPassword,
      onChanged: (password) {
        setState(() {
          _password = password;
        });
      },
      validator: (text) {
        if (text.isEmpty) {
          return I.of(context).doNotEmptyMessage;
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
        hintText: I.of(context).passwordHintText,
      ),
    );

    final _signInButton = RoundedButton(
      key: const Key('sign_in_form_sign_in_with_email_and_password'),
      text: 'Sign in',
      color: splashColor,
      onTap: !_isValid()
          ? null
          : () {
              if (!_formKey.currentState.validate()) {
                return;
              }
              _formKey.currentState.save();
              widget.onSignInWithEmailAndPassword(_email, _password);
            },
    );

    final _signInWithGoogleButton = RoundedButton(
      key: const Key('sign_in_form_sign_in_with_google'),
      text: 'Googleでログイン',
      color: Colors.redAccent,
      onTap: () {
        widget.onSignInWithGoogle();
      },
    );

    final _signInWithAppleButton = AppleSignInButton(
      style: siwa.ButtonStyle.black,
      type: siwa.ButtonType.signIn,
      onPressed: () {
        widget.onSignInWithApple();
      },
    );

    final _signInByTestUserButton = RoundedButton(
      key: const Key('sign_in_form_sign_in_by_test_user'),
      text: 'Test User',
      color: Colors.white30,
      onTap: () {
        widget.onSignInWithEmailAndPassword('a@b.com', '123456');
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Email
          _emailField.padding(),
          // Password
          _passwordField.padding(),
          // Sign Up
          _signInButton.padding(),

//          const Divider(
//            indent: 20,
//            endIndent: 20,
//            color: Colors.grey,
//          ),

          // Google Sign in
          // _signInWithGoogleButton.padding(),

          if (appleSignInAvailable.isAvailable)
            _signInWithAppleButton.padding(),

          // _signInByTestUserButton.padding(),
        ],
      ),
    );
  }
}
