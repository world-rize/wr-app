// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// リクエスト画面
class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('フレーズのリクエスト'),
      ),
      body: const SingleChildScrollView(
        child: Placeholder(
          fallbackHeight: 200,
        ),
      ),
    );
  }
}
