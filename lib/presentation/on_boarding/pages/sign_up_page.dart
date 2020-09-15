// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_up_form.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading;

  /// ホームへ移動
  Future<void> _gotoHome() {
    // debug
    final user = Provider.of<UserNotifier>(context, listen: false).user;
    InAppLogger.debugJson(user.toJson());

    // initial login
    Provider.of<SystemNotifier>(context, listen: false)
        .setFirstLaunch(value: false);

    // login のみ
    sendEvent(event: AnalyticsEvent.logIn);

    Navigator.popUntil(context, (route) => route.isFirst);

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootView(),
      ),
    );
  }

  /// Email & パスワード でサインアップ
  Future<void> _signUpWithEmailAndPassword(
      String email, String password, String name) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final an = context.read<AuthNotifier>();
      await an.signUpWithEmailAndPassword(
          email: email, password: password, name: name);
      await _gotoHome();
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });

      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Google でサインアップ
  Future<void> _signUpWithGoogle(String name) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final an = context.read<AuthNotifier>();
      await an.signUpWithGoogle(name);

      await _gotoHome();
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });

      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Apple でサインアップ
  Future<void> _signUpWithApple(String name) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final an = context.read<AuthNotifier>();
      await an.signUpWithApple(name);

      await _gotoHome();
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });

      InAppLogger.error(e);
      NotifyToast.error(e);
    }
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
        title: const Text('サインアップ'),
      ),
      body: LoadingView(
        loading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SignUpForm(
                onSignUpWithEmailAndPassword: _signUpWithEmailAndPassword,
                onSignUpWithGoogle: _signUpWithGoogle,
                onSignUpWithApple: _signUpWithApple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
