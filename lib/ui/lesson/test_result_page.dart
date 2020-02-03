// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
