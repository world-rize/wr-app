// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

class PasswordFormPage extends StatefulWidget {
  @override
  _PasswordFormPageState createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _currentPassword = '';
  String _newPassword = '';

  bool _isValid() {
    return _currentPassword.length >= 6 && _newPassword.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    final an = context.watch<AuthNotifier>();

    final _currentPasswordField = TextFormField(
      obscureText: !_showPassword,
      onChanged: (password) {
        setState(() {
          _currentPassword = password;
        });
      },
      validator: (text) {
        if (text.length < 6) {
          return I.of(context).invalidPasswordMessage;
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
        hintText: I.of(context).currentPasswordHintText,
      ),
    );

    final _newPasswordField = TextFormField(
      obscureText: !_showPassword,
      onChanged: (password) {
        setState(() => _newPassword = password);
      },
      validator: (text) {
        if (text.length < 6) {
          return I.of(context).invalidPasswordMessage;
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
        hintText: I.of(context).newPasswordHintText,
      ),
    );

    final _updatePasswordButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: I.of(context).changeButtonText,
          color: Colors.blueAccent,
          onTap: !_isValid()
              ? () {}
              : () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    an.setPassword(
                      currentPassword: _currentPassword,
                      newPassword: _newPassword,
                    );
                  }
                },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワードを変更'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: _currentPasswordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: _newPasswordField,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _updatePasswordButton,
            ),
          ],
        ),
      ),
    );
  }
}
