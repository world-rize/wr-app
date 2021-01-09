// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/notifier/test_page_notifier.dart';
import 'package:wr_app/presentation/lesson/pages/test_result_page.dart';
import 'package:wr_app/presentation/lesson/widgets/test_choices.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/usecase/user_service.dart';

/// テストページ
///
class TestPage extends StatelessWidget {
  const TestPage({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final us = GetIt.I<UserService>();
    final ln = Provider.of<LessonNotifier>(context);
    return ChangeNotifierProvider.value(
      value: TestPageNotifier(
        choiceSources: ln.phrases,
        section: section,
        userService: us,
      ),
      child: _TestPage(),
    );
  }
}

class _TestPage extends StatelessWidget {
  void _showConfirmDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testInterrupt),
        content: Text(I.of(context).testInterruptDetail),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I.of(context).yes),
            onPressed: () {
              // pop dialog
              Navigator.pop(context);
              // pop this view
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: Text(I.of(context).no),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future _goResultPage(BuildContext context, TestStats stats) async {
    // pop TestPage
    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TestResultPage(stats: stats)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final tn = Provider.of<TestPageNotifier>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingView(
        loading: tn.isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(I.of(context).question(tn.index + 1)),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    _showConfirmDialog(context);
                  })
            ],
          ),
          body: TestChoices(
              phrase: tn.section.phrases[tn.index],
              choices: tn.choices,
              answerIndex: tn.answerIndex,
              onNext: (answer) async {
                await tn.checkAnswer(answer);

                if (tn.index == tn.section.phrases.length - 1) {
                  final corrects = await tn.finishTest();

                  // get points
                  // TODO: fix
                  final un = Provider.of<UserNotifier>(context, listen: false);
                  await un.callGetPoint(points: corrects);

                  await _goResultPage(context, tn.stats);
                }

                tn.next();
              }),
        ),
      ),
    );
  }
}
