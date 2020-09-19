// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart' as siwa;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/apple_signin.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    @required this.onSignUpWithEmailAndPassword,
    @required this.onSignUpWithApple,
    @required this.onSignUpWithGoogle,
  });

  // email, password, name
  final Function(String, String, String) onSignUpWithEmailAndPassword;
  // name
  final Function(String) onSignUpWithGoogle;
  final Function(String) onSignUpWithApple;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _agree;
  bool _showPassword;
  bool _showConfirmationPassword;
  String _name;
  String _email;
  String _password;
  String _confirmationPassword;

  @override
  void initState() {
    super.initState();
    _agree = false;
    _showPassword = false;
    _showConfirmationPassword = false;
    _name = '';
    _email = '';
    _password = '';
    _confirmationPassword = '';
  }

  bool _isValid() {
    return _name.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _password.length >= 6 &&
        _confirmationPassword.isNotEmpty &&
        _agree &&
        _password == _confirmationPassword;
  }

  bool _isValidName() {
    return _name.isNotEmpty && _agree;
  }

  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    const splashColor = Color(0xff56c0ea);
    final appleSignInAvailable = GetIt.I<AppleSignInAvailable>();

    final _nameField = TextFormField(
      key: const Key('name'),
      onChanged: (name) {
        setState(() => _name = name);
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
        hintText: '名前',
      ),
    );

    final _emailField = TextFormField(
      key: const Key('email'),
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
      key: const Key('password'),
      obscureText: !_showPassword,
      onChanged: (password) {
        setState(() => _password = password);
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
            _showPassword ? Icons.remove_circle_outline : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() => _showPassword = !_showPassword);
          },
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: 'パスワード(6文字以上)',
      ),
    );

    final _confirmationPasswordField = TextFormField(
      key: const Key('password_confirm'),
      obscureText: !_showConfirmationPassword,
      onChanged: (text) {
        setState(() => _confirmationPassword = text);
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
            _showConfirmationPassword
                ? Icons.remove_circle_outline
                : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() {
              _showConfirmationPassword = !_showConfirmationPassword;
            });
          },
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: 'パスワード(確認用)',
      ),
    );

    final _acceptTermsCheckbox = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
      ),
      child: CheckboxListTile(
        key: const Key('agree'),
        value: _agree,
        activeColor: Colors.blue,
        title: Text.rich(
          // TODO: error
          TextSpan(
            text: '',
            children: [
              TextSpan(
                text: '利用規約',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    if (await canLaunch(env.privacyPolicyJaUrl)) {
                      await launch(
                        env.privacyPolicyJaUrl,
                        forceSafariVC: false,
                        forceWebView: false,
                      );
                    }
                  },
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              const TextSpan(text: 'に同意します'),
            ],
          ),
        ),
        onChanged: (value) {
          setState(() => _agree = value);
        },
      ),
    );

    final _signUpButton = RoundedButton(
      key: const Key('sign_up_form_sign_up_button'),
      text: 'Sign up',
      color: splashColor,
      onTap: !_isValid()
          ? null
          : () {
              if (!_formKey.currentState.validate()) {
                return;
              }
              _formKey.currentState.save();

              widget.onSignUpWithEmailAndPassword(_email, _password, _name);
            },
    );

    final _signUpWithGoogleButton = RoundedButton(
      key: const Key('sign_up_form_sign_up_with_google_button'),
      text: 'Sign up with Google',
      color: Colors.redAccent,
      onTap: !_isValidName()
          ? null
          : () {
              if (!_isValidName()) {
                return;
              }
              _formKey.currentState.save();

              widget.onSignUpWithGoogle(_name);
            },
    );

    final _signInWithAppleButton = siwa.AppleSignInButton(
      style: siwa.ButtonStyle.black,
      type: siwa.ButtonType.signIn,
      onPressed: !_isValidName()
          ? null
          : () {
              if (!_isValidName()) {
                return;
              }
              _formKey.currentState.save();

              widget.onSignUpWithApple(_name);
            },
    );

    final _signUpByTestUserButton = RoundedButton(
      key: const Key('sign_up_form_sign_up_by_test_user_button'),
      text: 'Test User',
      color: Colors.white30,
      onTap: () {
        widget.onSignUpWithEmailAndPassword('a@b.com', '123456', 'てすと');
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Name
          _nameField.padding(),

          // Email
          _emailField.padding(),

          // Password
          _passwordField.padding(),

          // Password Confirm
          _confirmationPasswordField.padding(),

          // Agree
          Padding(
            padding: const EdgeInsets.all(8),
            child: _acceptTermsCheckbox,
          ),

          // Sign Up Button
          _signUpButton.padding(),

          // Or
          const Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),

          // Google Sign up
          _signUpWithGoogleButton.padding(),

          // Sign up with siwa
          if (appleSignInAvailable.isAvailable)
            _signInWithAppleButton.padding(),

          // test user
          _signUpByTestUserButton.padding(),
        ],
      ),
    ).padding();
  }
}
