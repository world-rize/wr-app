// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:flutter/material.dart';

class LoggerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログ'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('Hoge'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
