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
      body: Column(
        children: const [
          Text('お知らせ'),
        ],
      ),
    );
  }
}
