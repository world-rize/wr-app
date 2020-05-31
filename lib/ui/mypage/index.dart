// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';

class MyPagePage extends StatelessWidget {
  Widget _cell() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Expanded(
            child: Icon(
              Icons.email,
              size: 80,
              color: Colors.grey,
            ),
          ),
          Text(
            'メニュー',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('${userStore.user.name} さん'),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('テスト本日残り${userStore.user.testLimitCount} 回'),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text('レッスン別達成率: xxx %'),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _cell(),
              _cell(),
              _cell(),
              _cell(),
            ],
          ),
        ),
      ],
    );
  }
}
