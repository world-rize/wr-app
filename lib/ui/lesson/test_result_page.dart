// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/lesson/section_select_page.dart';

class TestResultPage extends StatelessWidget {
  final Section section;
  TestResultPage({@required this.section});

  void _showRewardDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Test Clear!'),
        content: Column(
          children: <Widget>[
            Text('7ポイントGet!'),
            Text('ピースのカケラGet!'),
            Image.network('https://zettoku.up.seesaa.net/image/pazuru01.jpg'),
            GFButton(
              color: Colors.orange,
              text: '閉じる',
              size: GFSize.large,
              shape: GFButtonShape.pills,
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              onPressed: () {
                // pop history
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SectionSelectPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('7問中2問正解！テストに合格！', style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Column(
                children: section.phrases.map((phrase) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PhraseView(context, phrase),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          onPressed: () {
            _showRewardDialog(context);
          },
          label: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 100.0),
            child: Text('次へ', style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
