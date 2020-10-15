// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

class NameFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NameFormPageModel(),
      child: _NameFormPage(),
    );
  }
}

class NameFormPageModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  GlobalKey<FormState> get formKey => _formKey;
}

class _NameFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final un = context.watch<UserNotifier>();
    final state = context.watch<NameFormPageModel>();

    final _emailField = TextFormField(
      initialValue: un.user.name,
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
        hintText: 'Name',
      ),
    );

    final _setNameButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: 'Change',
          color: Colors.blueAccent,
          onTap: () {
            if (state.formKey.currentState.validate()) {
              state.formKey.currentState.save();
              un.setName(name: state.name);
            }
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
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
                    // Email
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: _emailField,
                    ),
                  ],
                ),
              ),
            ),

            // Sign Up
            Padding(
              padding: const EdgeInsets.all(8),
              child: _setNameButton,
            ),
          ],
        ),
      ),
    );
  }
}
