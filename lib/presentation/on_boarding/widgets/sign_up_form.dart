// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/toast.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({@required this.onSubmit, @required this.onSuccess});

  Function onSubmit;

  Function onSuccess;

  @override
  _SignUpFormState createState() =>
      _SignUpFormState(onSubmit: onSubmit, onSuccess: onSuccess);
}

class _SignUpFormState extends State<SignUpForm> {
  _SignUpFormState({@required this.onSubmit, @required this.onSuccess});

  final _formKey = GlobalKey<FormState>();

  Function onSubmit;

  Function onSuccess;

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

  /// call when SignUp button tapped.
  Future<void> _signUp() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    try {
      await Provider.of<UserNotifier>(context, listen: false)
          .signUpWithEmailAndPassword(
              email: _email, password: _password, name: _name, age: '')
          .catchError(print);

      Provider.of<SystemNotifier>(context, listen: false)
          .setFirstLaunch(value: false);
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

  /// call when SignUpWithGoogle button tapped.
  Future<void> _signUpWithGoogle() async {
    try {
      await Provider.of<UserNotifier>(context, listen: false)
          .signUpWithGoogle();

      Provider.of<SystemNotifier>(context, listen: false)
          .setFirstLaunch(value: false);

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

  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    final _nameField = TextFormField(
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
        hintText: '表示名',
      ),
    );

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
        hintText: 'パスワード',
      ),
    );

    final _confirmationPasswordField = TextFormField(
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
        value: _agree,
        activeColor: Colors.blue,
        title: const Text('利用規約に同意します'),
        onChanged: (value) {
          setState(() => _agree = value);
        },
      ),
    );

    final _signUpButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RoundedButton(
          text: 'Sign up',
          color: splashColor,
          onTap: !_isValid() ? null : _signUp,
        ),
      ),
    );

    final _signUpWithGoogleButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RoundedButton(
          text: 'Sign up with Google',
          color: Colors.redAccent,
          onTap: _signUpWithGoogle,
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _nameField,
          ),

          // Email
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _emailField,
          ),

          // Password
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _passwordField,
          ),

          // Password Confirm
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _confirmationPasswordField,
          ),

          // Agree
          Padding(
            padding: const EdgeInsets.all(16),
            child: _acceptTermsCheckbox,
          ),

          // Sign Up Button
          Padding(
            padding: const EdgeInsets.all(8),
            child: _signUpButton,
          ),

          // Or
          const Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),

          // Google Sign up
          Padding(
            padding: const EdgeInsets.all(8),
            child: _signUpWithGoogleButton,
          ),
        ],
      ),
    );
  }
}
