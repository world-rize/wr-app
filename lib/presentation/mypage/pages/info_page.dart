// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';

/// mypage > index > InformationPage
class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).myPageInfoButton),
      ),
      body: Center(
        child: Text(
          I.of(context).myPageInfoNotFound,
          style: const TextStyle(color: Colors.grey, fontSize: 24),
        ),
      ),
    );
  }
}
