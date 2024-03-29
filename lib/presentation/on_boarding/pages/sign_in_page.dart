// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_in_form.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/ui/theme.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading;

  /// ホームへ移動
  Future<void> _gotoHome() {
    Provider.of<SystemNotifier>(context, listen: false)
        // initial login
        .setFirstLaunch(value: false);

    sendEvent(event: AnalyticsEvent.logIn);

    Navigator.popUntil(context, (route) => route.isFirst);
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootView(),
      ),
    );
  }

  /// Email & パスワードでログイン
  Future<void> _signInWithEmailAndPassword(
      String email, String password) async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final an = context.read<AuthNotifier>();
      await an.signInWithEmailAndPassword(email, password);

      NotifyToast.success(I.of(context).signInSuccessful);
      await _gotoHome();
    } on PlatformException catch (e) {
      // TODO: suppress to report to sentry
      InAppLogger.error(e);
      final mes = e.toLocalizedMessage(context);
      NotifyToast.error(mes);
    } on Exception catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Google でログイン
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final an = context.read<AuthNotifier>();
      await an.signInWithGoogle();

      NotifyToast.success(I.of(context).signInSuccessful);
      await _gotoHome();
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });

      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Apple でログイン
  Future<void> _signInWithApple() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final un = context.read<AuthNotifier>();
      await un.signInWithApple();

      NotifyToast.success(I.of(context).signInSuccessful);
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
    final splashColor = Palette.symbolColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashColor,
        title: Text(I.of(context).signInButton),
      ),
      body: LoadingView(
        loading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SignInForm(
                onSignInWithEmailAndPassword: _signInWithEmailAndPassword,
                onSignInWithGoogle: _signInWithGoogle,
                onSignInWithApple: _signInWithApple,
              ).padding(),
            ],
          ),
        ),
      ),
    );
  }
}
