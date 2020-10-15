// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:apple_sign_in/apple_sign_in.dart' as siwa;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/apple_signin.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    @required this.onSignUpWithEmailAndPassword,
    @required this.onSignUpWithApple,
    @required this.onSignUpWithGoogle,
  });

  final Function(String email, String password, String name)
      onSignUpWithEmailAndPassword;

  final Function(String name) onSignUpWithGoogle;
  final Function(String name) onSignUpWithApple;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SignUpFormModel(),
      child: _SignUpForm(
        onSignUpWithGoogle: onSignUpWithGoogle,
        onSignUpWithApple: onSignUpWithApple,
        onSignUpWithEmailAndPassword: onSignUpWithEmailAndPassword,
      ),
    );
  }
}

class SignUpFormModel extends ChangeNotifier {
  SignUpFormModel()
      : _agree = false,
        _showPassword = false,
        _showConfirmationPassword = false,
        _name = '',
        _email = '',
        _password = '',
        _confirmationPassword = '';

  final _formKey = GlobalKey<FormState>();
  bool _agree;
  bool _showPassword;
  bool _showConfirmationPassword;
  String _name;
  String _email;
  String _password;
  String _confirmationPassword;

  GlobalKey<FormState> get formKey => _formKey;

  bool get showPassword => _showPassword;

  bool get showConfirmationPassword => _showConfirmationPassword;

  set showConfirmationPassword(bool value) {
    _showConfirmationPassword = value;
    notifyListeners();
  }

  set confirmationPassword(String confirmationPassword) {
    _confirmationPassword = confirmationPassword;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set showPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  bool get agree => _agree;

  set agree(bool value) {
    _agree = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  bool get isValid =>
      _name.isNotEmpty &&
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      _password.length >= 6 &&
      _confirmationPassword.isNotEmpty &&
      _agree &&
      _password == _confirmationPassword;

  bool get isValidName => _name.isNotEmpty && _agree;
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({
    @required this.onSignUpWithEmailAndPassword,
    @required this.onSignUpWithApple,
    @required this.onSignUpWithGoogle,
  });

  final Function(String email, String password, String name)
      onSignUpWithEmailAndPassword;

  final Function(String name) onSignUpWithGoogle;
  final Function(String name) onSignUpWithApple;

  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    const splashColor = Color(0xff56c0ea);
    final appleSignInAvailable = GetIt.I<AppleSignInAvailable>();
    final state = context.watch<SignUpFormModel>();

    final _nameField = TextFormField(
      key: const Key('name'),
      onChanged: (name) {
        state.name = name;
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
        state.email = email;
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
      obscureText: !state.showPassword,
      onChanged: (password) {
        state.password = password;
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
            state.showPassword
                ? Icons.remove_circle_outline
                : Icons.remove_red_eye,
          ),
          onPressed: () {
            state.showPassword = !state.showPassword;
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
      obscureText: !state.showConfirmationPassword,
      onChanged: (text) {
        state.confirmationPassword = text;
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
            state.showConfirmationPassword
                ? Icons.remove_circle_outline
                : Icons.remove_red_eye,
          ),
          onPressed: () {
            state.showConfirmationPassword = !state.showConfirmationPassword;
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
        value: state.agree,
        activeColor: Colors.blue,
        title: Text.rich(
          // TODO: error
          TextSpan(
            text: '',
            children: [
              TextSpan(
                text: I.of(context).termsOfService,
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
          state.agree = value;
        },
      ),
    );

    final _signUpButton = RoundedButton(
      key: const Key('sign_up_form_sign_up_button'),
      text: 'Sign up',
      color: splashColor,
      onTap: !state.isValid
          ? null
          : () {
              if (!state.formKey.currentState.validate()) {
                return;
              }
              state.formKey.currentState.save();

              onSignUpWithEmailAndPassword(
                state.email,
                state.password,
                state.name,
              );
            },
    );

    final _signUpWithGoogleButton = RoundedButton(
      key: const Key('sign_up_form_sign_up_with_google_button'),
      text: 'Sign up with Google',
      color: Colors.redAccent,
      onTap: !state.isValidName
          ? null
          : () {
              if (!state.isValidName) {
                return;
              }
              state.formKey.currentState.save();

              onSignUpWithGoogle(state.name);
            },
    );

    final _signInWithAppleButton = siwa.AppleSignInButton(
      style: siwa.ButtonStyle.black,
      type: siwa.ButtonType.signIn,
      onPressed: !state.isValidName
          ? null
          : () {
              if (!state.isValidName) {
                return;
              }
              state.formKey.currentState.save();

              onSignUpWithApple(state.name);
            },
    );

    final _signUpByTestUserButton = RoundedButton(
      key: const Key('sign_up_form_sign_up_by_test_user_button'),
      text: 'Test User',
      color: Colors.white30,
      onTap: () {
        onSignUpWithEmailAndPassword('a@b.com', '123456', 'てすと');
      },
    );

    return Form(
      key: state.formKey,
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
