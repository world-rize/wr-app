// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_up_form.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/util/analytics.dart';

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

  void _gotoHome() {
    Provider.of<SystemNotifier>(context, listen: false)
        // initial login
        .setFirstLaunch(value: false);

    sendEvent(event: AnalyticsEvent.logIn);

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootView(),
      ),
    );
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
                _gotoHome();
              },
            ),
          ],
        ),
      ),
    );
  }
}
