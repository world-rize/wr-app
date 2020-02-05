// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/ui/lesson/section_select_page.dart';

class TestResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Test'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Text('7問中2問正解！テストに合格！'),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Placeholder(fallbackHeight: 60);
                },
                itemCount: 10,
              ),
            ),
            GFButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SectionSelectPage()),
                );
              },
              text: '戻る',
            ),
          ],
        ),
      ),
    );
  }
}
