// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';

class APITestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('APIテスト'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: userStore.callTestApi,
            color: Colors.blueAccent,
            child: const Text('Call Test Api'),
          ),
          FlatButton(
            onPressed: userStore.callCreateUserApi,
            color: Colors.blueAccent,
            child: const Text('Call CreateUser Api'),
          )
        ],
      ),
    );
  }
}
