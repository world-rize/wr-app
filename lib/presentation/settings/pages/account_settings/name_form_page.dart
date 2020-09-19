// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

class NameFormPage extends StatefulWidget {
  @override
  _NameFormPageState createState() => _NameFormPageState();
}

class _NameFormPageState extends State<NameFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    final un = context.watch<UserNotifier>();

    final _emailField = TextFormField(
      initialValue: un.user.name,
      onChanged: (name) {
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
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              un.setName(name: _name);
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
                key: _formKey,
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
