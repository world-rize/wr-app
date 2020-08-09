// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_in_form.dart';
import 'package:wr_app/util/extensions.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              SignInForm().p_1(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
