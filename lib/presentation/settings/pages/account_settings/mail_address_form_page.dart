// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';

class MailAddressFormPage extends StatefulWidget {
  @override
  _MailAddressFormPageState createState() => _MailAddressFormPageState();
}

class _MailAddressFormPageState extends State<MailAddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final an = context.watch<AuthNotifier>();

    final _emailField = TextFormField(
      initialValue: an.user.attributes.email,
      onChanged: (email) {
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

    final _signUpButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: '変更',
          color: Colors.blueAccent,
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              an.setEmail(email: _email);
            }
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('メールアドレスを変更'),
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
              child: _signUpButton,
            ),
          ],
        ),
      ),
    );
  }
}
