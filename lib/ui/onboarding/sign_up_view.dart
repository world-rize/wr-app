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
      'assets/icon/wr_icon.jpg',
      fit: BoxFit.contain,
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          logo,
          // Form
          Padding(
            padding: const EdgeInsets.all(8),
            child: SignUpForm(),
          ),
        ],
      ),
    );
  }
}
