// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

class PasswordFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PasswordFormPageModel(),
      child: _PasswordFormPage(),
    );
  }
}

class PasswordFormPageModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  String _currentPassword = '';
  String _newPassword = '';

  GlobalKey<FormState> get formKey => _formKey;

  bool get showPassword => _showPassword;

  set showPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  String get currentPassword => _currentPassword;

  set currentPassword(String value) {
    _currentPassword = value;
    notifyListeners();
  }

  String get newPassword => _newPassword;

  set newPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }
}

class _PasswordFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final an = context.watch<AuthNotifier>();
    final state = context.watch<PasswordFormPageModel>();

    final _currentPasswordField = TextFormField(
      obscureText: !state.showPassword,
      onChanged: (password) {
        state.currentPassword = password;
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
            state.showPassword
                ? Icons.remove_circle_outline
                : Icons.remove_red_eye,
          ),
          onPressed: () {
            state.showPassword = !state.showPassword;
          },
        ),
        hintText: '現在のパスワード',
      ),
    );

    final _newPasswordField = TextFormField(
      obscureText: !state.showPassword,
      onChanged: (password) {
        state.newPassword = password;
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
            state.showPassword
                ? Icons.remove_circle_outline
                : Icons.remove_red_eye,
          ),
          onPressed: () {
            state.showPassword = !state.showPassword;
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
            if (state.formKey.currentState.validate()) {
              state.formKey.currentState.save();
              an.setPassword(
                currentPassword: state.currentPassword,
                newPassword: state.newPassword,
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
                key: state.formKey,
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
