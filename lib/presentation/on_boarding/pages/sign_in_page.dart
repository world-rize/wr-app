// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_in_form.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/extensions.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading;

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
        title: const Text('Signin'),
      ),
      // TODO(someone): height = maxHeight - appBarHeight
      body: LayoutBuilder(
        builder: (_, constraints) => ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: <Widget>[
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              SignInForm(
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
              ).p_1(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
