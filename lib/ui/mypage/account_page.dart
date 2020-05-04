// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(userStore.user.toJson().toString()),
          ],
        ),
      ),
    );
  }
}
