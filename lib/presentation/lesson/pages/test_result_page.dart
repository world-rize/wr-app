// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/extensions.dart';
import 'package:wr_app/presentation/lesson/pages/phrase_page_view/index.dart';
import 'package:wr_app/presentation/lesson/widgets/challenge_achieved_dialog.dart';
import 'package:wr_app/presentation/lesson/widgets/reward_dialog.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

import '../widgets/phrase_card.dart';

class TestResultPageModel extends ChangeNotifier {
  TestResultPageModel({@required this.stats});

  final TestStats stats;

  /// 報酬獲得画面
  Future _showRewardDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => RewardDialog(
        text: Text(I.of(context).getPoints(stats.corrects)),
        onTap: () {
          // pop history
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }

  /// アンケートを出す
  Future _showQuestionnaireDialog(BuildContext context) {
    final sn = context.read<SystemNotifier>();
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
              sn.setQuestionnaireAnswered(value: true);
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
  Future _show30DaysChallengeAchievedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => ChallengeAchievedDialog(),
    );
  }

  // Nextぼたんをおしたとき
  Future _onTapNext(BuildContext context) async {
    final un = context.read<UserNotifier>();
    final sn = context.read<SystemNotifier>();

    // show dialog
    await _showRewardDialog(context);

    // 30 days challenge
    if (stats.challengeAchieved) {
      await _show30DaysChallengeAchievedDialog(context);
    }

    // 最後のテストでアンケート誘導
    if (!sn.getQuestionnaireAnswered() &&
        un.user.statistics.testLimitCount == 0) {
      await _showQuestionnaireDialog(context);
    }
  }

  Future onFavorite(BuildContext context, int index) async {
    final phrase = stats.section.phrases[index];
    final un = context.read<UserNotifier>();
    await un.favoritePhrase(
      phraseId: phrase.id,
      favorite: !un.existPhraseInFavoriteList(phraseId: phrase.id),
    );
  }

  Future onTap(BuildContext context, int index) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PhrasePageView(section: stats.section, index: index),
      ),
    );
  }

  Widget phraseCard(BuildContext context, int index) {
    final un = context.read<UserNotifier>();

    return PhraseCard(
      highlight: stats.answers[index] ? Colors.green : Colors.red,
      phrase: stats.section.phrases[index],
      onTap: () => onTap(context, index),
      favorite: un.existPhraseInFavoriteList(
          phraseId: stats.section.phrases[index].id),
      onFavorite: () => onFavorite(context, index),
    );
  }
}

class TestResultPage extends StatelessWidget {
  const TestResultPage({@required this.stats});

  // 出題セクション
  final TestStats stats;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TestResultPageModel(stats: stats),
      child: _TestResultPageState(),
    );
  }
}

class _TestResultPageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TestResultPageModel>();
    final primaryColor = Theme.of(context).primaryColor;

    final scoreText =
        I.of(context).testScore(state.stats.questions, state.stats.corrects);

    final resultList = List.generate(
      state.stats.section.phrases.length,
      (i) => state.phraseCard(context, i).padding(),
    );
    final nextButton = PrimaryButton(
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
        child: Text(
          I.of(context).next,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      onPressed: () => state._onTapNext(context),
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
