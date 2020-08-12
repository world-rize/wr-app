// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
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

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);

    final _currentPasswordField = TextFormField(
      obscureText: !_showPassword,
      onChanged: (password) {
        setState(() {
          _currentPassword = password;
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
        hintText: '現在のパスワード',
      ),
    );

    final _newPasswordField = TextFormField(
      obscureText: !_showPassword,
      onChanged: (password) {
        setState(() => _newPassword = password);
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
        hintText: '新しいパスワード',
      ),
    );

    final _updatePasswordButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: '変更',
          color: Colors.blueAccent,
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              userNotifier.setPassword(
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
