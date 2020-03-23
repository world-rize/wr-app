// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/lesson/section_select_page.dart';

/// テスト結果画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469140>
class TestResultPage extends StatelessWidget {
  const TestResultPage({@required this.section});

  final Section section;

  // TODO: 解答情報も保持

  /// 「ピースのカケラを取得」画面
  void _showRewardDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Test Clear!'),
        content: Column(
          children: <Widget>[
            const Text('7ポイントGet!'),
            const Text('ピースのカケラGet!'),
            Image.network('https://zettoku.up.seesaa.net/image/pazuru01.jpg'),
            GFButton(
              color: Colors.orange,
              text: '閉じる',
              size: GFSize.LARGE,
              shape: GFButtonShape.pills,
              padding: const EdgeInsets.symmetric(horizontal: 80),
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
        title: const Text('Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('7問中2問正解！テストに合格！', style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Column(
                children: section.phrases.map((phrase) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: phraseView(context, phrase),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          onPressed: () {
            _showRewardDialog(context);
          },
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 100),
            child: Text('次へ', style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
