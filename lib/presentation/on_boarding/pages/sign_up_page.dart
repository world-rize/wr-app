// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/presentation/on_boarding/pages/locale_choice_page.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashColor,
        title: const Text('サインアップ'),
      ),
      body: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: <Widget>[
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            SignUpForm(
              onSubmit: () {
                setState(() {
                  _isLoading = true;
                });
              },
              onSuccess: () {
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => LocaleChoicePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
