// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/i10n/i10n.dart';

/// リクエスト画面
class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(I.of(context).requestPhrase),
      ),
      body: const SingleChildScrollView(
        child: Placeholder(
          fallbackHeight: 200,
        ),
      ),
    );
  }
}
