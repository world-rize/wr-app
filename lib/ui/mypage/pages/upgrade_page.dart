// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// mypage > index > UpgradePage
class UpgradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('有料版購入'),
      ),
      body: Column(
        children: const [
          Text('有料版'),
        ],
      ),
    );
  }
}
