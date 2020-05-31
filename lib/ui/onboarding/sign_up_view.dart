// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/onboarding/widgets/sign_up_form.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/icon/icon.jpg',
      width: 200,
      fit: BoxFit.contain,
    );

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: logo,
            ),
            // Form
            Padding(
              padding: const EdgeInsets.all(8),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}
