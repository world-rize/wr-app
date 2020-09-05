// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/extensions.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

import './section_list_page.dart';
import './test_page.dart';
import '../widgets/phrase_widget.dart';

/// テスト結果画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469140>
class TestResultPage extends StatelessWidget {
  const TestResultPage({@required this.stats});

  final TestStats stats;

  /// 報酬獲得画面
  Future<void> _showRewardDialog(BuildContext context) {
    return showCupertinoDialog(
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

  /// アンケートを出す
  Future<void> _showQuestionnaireDialog(BuildContext context) {
    final systemNotifier = Provider.of<SystemNotifier>(context);
    final env = DotEnv().env;
    final questionnaireUrl = env['QUESTIONNAIRE_URL'];
    assert(questionnaireUrl != '');

    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('アンケートに答えてください'),
        content: const Text('アンケートに答えてください'),
        actions: <Widget>[
          CupertinoButton(
            child: const Text('答える'),
            onPressed: () async {
              systemNotifier.setQuestionnaireAnswered(value: true);
              Navigator.pop(context);
              if (await canLaunch(questionnaireUrl)) {
                await launch(
                  questionnaireUrl,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              }
            },
          ),
          CupertinoButton(
            child: const Text('後で'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final userNotifier = Provider.of<UserNotifier>(context);
    final systemNotifier = Provider.of<SystemNotifier>(context);
    final scoreText = I.of(context).testScore(stats.questions, stats.corrects);

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
              scoreText,
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
                    favorite: userNotifier.existPhraseInFavoriteList(
                        phraseId: stats.section.phrases[i].id),
                    onFavorite: () {
                      final phrase = stats.section.phrases[i];
                      userNotifier.favoritePhrase(
                        phraseId: phrase.id,
                        favorite: !userNotifier.existPhraseInFavoriteList(
                            phraseId: phrase.id),
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
          onPressed: () async {
            // send score
            await userNotifier.sendTestScore(
                sectionId: stats.section.id, score: stats.corrects);
            // get points
            await userNotifier.callGetPoint(points: stats.corrects);
            // show dialog
            await _showRewardDialog(context);

            // 最後のテストでアンケート誘導
            if (!systemNotifier.getQuestionnaireAnswered() &&
                userNotifier.getUser().statistics.testLimitCount == 0) {
              await _showQuestionnaireDialog(context);
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
