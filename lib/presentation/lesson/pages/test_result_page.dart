// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/extensions.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/lesson/pages/section_list_page.dart';
import 'package:wr_app/ui/lesson/pages/test_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

/// テスト結果画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469140>
class TestResultPage extends StatelessWidget {
  const TestResultPage({@required this.stats});

  final TestStats stats;

  /// 報酬獲得画面
  void _showRewardDialog(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testClear),
        content: Column(
          children: <Widget>[
            Text(I.of(context).getPoints(stats.corrects)),
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
    final userStore = Provider.of<UserNotifier>(context);
    final user = userStore.getUser();
    final scoreText = I.of(context).testScore(stats.questions, stats.corrects);
    final resultText = I.of(context).testResult(stats.corrects > 5);

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
                  (i) => PhraseCard(
                    highlight: stats.answers[i] ? Colors.green : Colors.red,
                    phrase: stats.section.phrases[i],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SectionDetailPage(
                              section: stats.section, index: i),
                        ),
                      );
                    },
                    favorite: user.isFavoritePhrase(stats.section.phrases[i]),
                    onFavorite: () {
                      final phrase = stats.section.phrases[i];
                      userStore.favoritePhrase(
                        phraseId: phrase.id,
                        value: !user.isFavoritePhrase(phrase),
                      );
                    },
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
            userStore.callGetPoint(point: stats.corrects);
            _showRewardDialog(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
