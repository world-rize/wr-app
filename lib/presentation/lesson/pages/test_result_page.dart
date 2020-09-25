// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/extensions.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/lesson/widgets/challenge_achieved_dialog.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

import '../widgets/phrase_card.dart';

/// テスト結果画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469140>
class TestResultPage extends StatefulWidget {
  const TestResultPage({@required this.stats});

  final TestStats stats;

  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  /// 報酬獲得画面
  Future<void> _showRewardDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testClear),
        content: Column(
          children: <Widget>[
            Text(I.of(context).getPoints(widget.stats.corrects)),
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
    final systemNotifier = Provider.of<SystemNotifier>(context, listen: false);
    final env = DotEnv().env;
    final questionnaireUrl = env['QUESTIONNAIRE_URL'];

    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).showQuestionnaireDialogTitle),
        content: const Text('アンケートに答えてください'),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I.of(context).showQuestionnaireDialogOk),
            onPressed: () async {
              systemNotifier.setQuestionnaireAnswered(value: true);
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
            child: Text(I.of(context).showQuestionnaireDialogNg),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// 30days challenge 達成
  Future<void> _show30DaysChallengeAchievedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => ChallengeAchievedDialog(),
    );
  }

  void _onTapNext() async {
    final un = context.read<UserNotifier>();
    final sn = context.read<SystemNotifier>();

    // send score
    await un.sendTestScore(
        sectionId: widget.stats.section.id, score: widget.stats.corrects);
    // get points
    await un.callGetPoint(points: widget.stats.corrects);
    // show dialog
    await _showRewardDialog(context);

    final is30DaysChallengeAchieved = await un.checkTestStreaks();

    if (true || is30DaysChallengeAchieved) {
      await _show30DaysChallengeAchievedDialog(context);
    }

    // 最後のテストでアンケート誘導
    if (!sn.getQuestionnaireAnswered() &&
        un.user.statistics.testLimitCount == 0) {
      await _showQuestionnaireDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final userNotifier = Provider.of<UserNotifier>(context);

    final scoreText =
        I.of(context).testScore(widget.stats.questions, widget.stats.corrects);

    final resultList = List.generate(
      widget.stats.section.phrases.length,
      (i) => PhraseCard(
        highlight: widget.stats.answers[i] ? Colors.green : Colors.red,
        phrase: widget.stats.section.phrases[i],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  SectionPage(section: widget.stats.section, index: i),
            ),
          );
        },
        favorite: userNotifier.existPhraseInFavoriteList(
            phraseId: widget.stats.section.phrases[i].id),
        onFavorite: () {
          final phrase = widget.stats.section.phrases[i];
          userNotifier.favoritePhrase(
            phraseId: phrase.id,
            favorite:
                !userNotifier.existPhraseInFavoriteList(phraseId: phrase.id),
          );
        },
      ).padding(),
    );
    final nextButton = PrimaryButton(
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
        child: Text(
          I.of(context).next,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      onPressed: _onTapNext,
    );

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
            ).padding(),
            Container(
              child: Column(
                children: resultList,
              ),
            ),
            Center(child: nextButton.padding()),
          ],
        ).padding(),
      ),
    );
  }
}
