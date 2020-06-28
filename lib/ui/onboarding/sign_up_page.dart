// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/preferences.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/common/toast.dart';
import 'package:wr_app/ui/onboarding/widgets/rounded_button.dart';
import 'package:wr_app/ui/root_view.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _agree;
  bool _showPassword;
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    _agree = false;
    _showPassword = false;
    _email = '';
    _password = '';
  }

  Future<void> _signUpEmailAndPassword() async {
    final preferences = Provider.of<PreferencesStore>(context, listen: false);
    final userStore = Provider.of<UserStore>(context, listen: false);
    print('email: $_email password: $_password');

    try {
      await userStore
          .signUpWithEmailAndPassword(_email, _password)
          .catchError(print);

      preferences.setFirstLaunch(flag: false);
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootView(),
        ),
      );
    } on Exception catch (e) {
      print(e);
      NotifyToast.error(e);
      return;
    }
  }

  Future<void> _signUpWithGoogle() async {
    final preferences = Provider.of<PreferencesStore>(context, listen: false);
    final userStore = Provider.of<UserStore>(context, listen: false);
    try {
      await userStore.signUpWithGoogle();

      preferences.setFirstLaunch(flag: false);

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootView(),
        ),
      );
    } on Exception catch (e) {
      print(e);
      NotifyToast.error(e);
      return;
    }
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
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: 'Password',
      ),
    );

    final _acceptTermsCheckbox = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
      ),
      child: CheckboxListTile(
        value: _agree,
        activeColor: Colors.blue,
        title: const Text('利用規約に同意します'),
//        subtitle: !_agree
//            ? const Text(
//                'required',
//                style: TextStyle(color: Colors.red),
//              )
//            : null,
        onChanged: (value) {
          setState(() {
            _agree = value;
          });
        },
      ),
    );

    final _signUpButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RoundedButton(
          text: 'Sign up',
          color: splashColor,
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _signUpEmailAndPassword();
            }
          },
        ),
      ),
    );

    final _signUpWithGoogleButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RoundedButton(
          text: 'Sign up with Google',
          color: Colors.redAccent,
          onTap: _signUpWithGoogle,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashColor,
        title: const Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: _emailField,
                      ),

                      // Password
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: _passwordField,
                      ),

                      // Agree
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: _acceptTermsCheckbox,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Sign Up
              Padding(
                padding: const EdgeInsets.all(8),
                child: _signUpButton,
              ),

              // Or
              const Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),

              // Google Sign up
              Padding(
                padding: const EdgeInsets.all(8),
                child: _signUpWithGoogleButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
