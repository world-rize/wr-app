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
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/lesson/widgets/challenge_achieved_dialog.dart';
import 'package:wr_app/presentation/lesson/widgets/reward_dialog.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/theme.dart';
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
  Future _showRewardDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => RewardDialog(
        text: Text(I.of(context).getPoints(widget.stats.corrects)),
        onTap: () {
          // pop history
          Navigator.popUntil(context, (route) => route.isFirst);
        },
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
  Future _onTapNext() async {
    final un = context.read<UserNotifier>();
    final sn = context.read<SystemNotifier>();

    // show dialog
    await _showRewardDialog(context);

    // 30 days challenge
//    if (widget.stats.challengeAchieved) {
//      await _show30DaysChallengeAchievedDialog(context);
//    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final un = Provider.of<UserNotifier>(context);
    final ln = Provider.of<LessonNotifier>(context);

    final scoreText =
        I.of(context).testScore(widget.stats.questions, widget.stats.corrects);

    final resultList = List.generate(
        widget.stats.section.phrases.length,
        (i) => FutureBuilder(
              future: ln.existPhraseInFavoriteList(
                  user: un.user, phraseId: widget.stats.section.phrases[i].id),
              builder: (context, snapshot) {
                var favorite = false;
                if (snapshot.hasData) {
                  favorite = snapshot.data;
                }
                return PhraseCard(
                  highlight: widget.stats.answers[i]
                      ? Palette.correctColor
                      : Palette.inCorrectColor,
                  phrase: widget.stats.section.phrases[i],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SectionPage(
                            section: widget.stats.section, index: i),
                      ),
                    );
                  },
                  favorite: favorite,
                  onFavorite: () {
                    final phrase = widget.stats.section.phrases[i];
                    ln.favoritePhrase(
                      phraseId: phrase.id,
                      favorite: favorite,
                      user: un.user,
                    );
                  },
                ).padding();
              },
            ));
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
