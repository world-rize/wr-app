// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/toast.dart';

class SignUpForm extends StatefulWidget {
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
    print('$_email, $_password, $_confirmationPassword');
    return _email != '' && _password == _confirmationPassword;
  }

  Future<void> _signIn(String email, String password, String name) async {
    print('$email $password $name');

    try {
      await Provider.of<UserNotifier>(context, listen: false)
          .signUpWithEmailAndPassword(
              email: email, password: password, name: name, age: '')
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

  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    final _nameField = TextFormField(
      onSaved: (name) {
        setState(() {
          _name = name;
        });
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
            _showPassword ? Icons.remove_circle_outline : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
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
      onSaved: (text) {
        setState(() {
          _confirmationPassword = text;
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
//        subtitle: !_agree
//            ? const Text(
//                'required',
//                style: TextStyle(color: Colors.red),
//              )
//            : null,
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
        child: RoundedButton(
          text: 'Sign up',
          color: splashColor,
          onTap: !_isValid()
              ? null
              : () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _signIn(_email, _password, _name);
                  }
                },
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
          onTap: () async {
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
          },
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
