// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/onboarding/widgets/sign_in_form.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/icon/icon.jpg',
      width: 200,
      fit: BoxFit.contain,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: logo,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: SignInForm(),
        ),
      ],
    );
  }
}
