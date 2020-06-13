// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/extension/padding_extension.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/test_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

/// テスト結果画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469140>
class TestResultPage extends StatelessWidget {
  const TestResultPage({@required this.stats});

  final TestStats stats;

  /// 「ピースのカケラを取得」画面
  void _showRewardDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testClear),
        content: Column(
          children: <Widget>[
            Text(I.of(context).getPoints(stats.corrects)),
            Text(I.of(context).getPiece),
            Image.network('https://zettoku.up.seesaa.net/image/pazuru01.jpg'),
            GFButton(
              color: Colors.orange,
              text: I.of(context).close,
              size: GFSize.LARGE,
              shape: GFButtonShape.pills,
              padding: const EdgeInsets.symmetric(horizontal: 80),
              onPressed: () {
                // pop history
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final useStore = Provider.of<UserStore>(context);
    final scoreText = I.of(context).testScore(stats.questions, stats.corrects);
    final resultText = I.of(context).testResult(true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$scoreText$resultText',
              style: const TextStyle(fontSize: 20),
            ).p_1(),
            Container(
              child: Column(
                children: List.generate(
                  stats.section.phrases.length,
                  (i) => Stack(
                    children: [
                      PhraseCard(
                        phrase: stats.section.phrases[i],
                        favorite: useStore.favorited(stats.section.phrases[i]),
                      ),
                      Text('${stats.answers[i]}'),
                    ],
                  ).p_1(),
                ),
              ),
            ),
          ],
        ).p_1(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: PrimaryButton(
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
            child: Text(
              I.of(context).next,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          onPressed: () {
            useStore.callGetPoint(point: stats.corrects);
            _showRewardDialog(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
