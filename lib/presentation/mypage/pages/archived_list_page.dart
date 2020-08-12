// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// mypage > index > ArchivedList
class ArchivedListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アーカイブ'),
      ),
      body: Column(
        children: const [
          Text('アーカイブ'),
        ],
      ),
    );
  }
}
