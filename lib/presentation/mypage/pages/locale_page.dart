// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// mypage > index > LocalePage
class LocalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アクセント追加'),
      ),
      body: Column(
        children: const [
          Text('アクセント追加'),
        ],
      ),
    );
  }
}
