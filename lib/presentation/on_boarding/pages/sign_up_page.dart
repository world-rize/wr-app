// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/presentation/on_boarding/widgets/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
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
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
