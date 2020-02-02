// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/section.dart';

class LessonTestPage extends StatelessWidget {
  final Section section;

  LessonTestPage({this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(section.title + 'のテスト'),
          ],
        ),
      ),
    );
  }
}
