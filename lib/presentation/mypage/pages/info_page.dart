// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// mypage > index > InformationPage
class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お知らせ'),
      ),
      body: const Center(
        child: Text(
          'お知らせはありません',
          style: TextStyle(color: Colors.grey, fontSize: 24),
        ),
      ),
    );
  }
}
