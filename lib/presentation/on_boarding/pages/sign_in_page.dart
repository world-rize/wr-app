// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/rounded_button.dart';
import 'package:wr_app/util/analytics.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword;
  String _email;
  String _password;

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

  Future<void> _signInEmailAndPassword(String email, String password) async {
    final notifier = Provider.of<UserNotifier>(context, listen: false);
    await notifier.loginWithEmailAndPassword(email, password);
    _gotoHome();
  }

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _email = '';
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    final _emailField = TextFormField(
      onSaved: (email) {
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

    final _passwordField = TextFormField(
      obscureText: !_showPassword,
      onSaved: (password) {
        setState(() {
          _password = password;
        });
      },
      validator: (text) {
        if (text.isEmpty) {
          return 'do not empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.remove_circle_outline : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
        hintText: 'Password',
      ),
    );

    final _signInButton = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          text: 'Sign in',
          color: splashColor,
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _signInEmailAndPassword(_email, _password);
            }
          },
        ),
      ),
    );

//    final _signInWithGoogleButton = Padding(
//      padding: const EdgeInsets.all(8),
//      child: SizedBox(
//        width: double.infinity,
//        child: RoundedButton(
//          onTap: _signInWithGoogle,
//          color: Colors.redAccent,
//          text: 'Sign in with Google',
//        ),
//      ),
//    );

    final _signInByTestUser = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RoundedButton(
          onTap: () {
            _signInEmailAndPassword('a@b.com', '123456');
          },
          text: 'Sign in by Test User(Debug)',
          color: Colors.grey,
        ),
      ),
    );

    final _signInForm = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Email
          Padding(
            padding: const EdgeInsets.all(8),
            child: _emailField,
          ),

          // Password
          Padding(
            padding: const EdgeInsets.all(8),
            child: _passwordField,
          ),
        ],
      ),
    );

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
              _signInForm.p_1(),

              const Spacer(),

              // Sign Up
              _signInButton.p_1(),

              const Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),

              // Google Sign up
              // _signInWithGoogleButton,

              _signInByTestUser.p_1(),
            ],
          ),
        ),
      ),
    );
  }
}
