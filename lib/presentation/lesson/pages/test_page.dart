// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/lesson/model/test_stats.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/test_result_page.dart';
import 'package:wr_app/presentation/lesson/test_notifier.dart';
import 'package:wr_app/presentation/lesson/widgets/test_choices.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/usecase/user_service.dart';

/// テストページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469139>
class TestPage extends StatelessWidget {
  const TestPage({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final us = GetIt.I<UserService>();
    return ChangeNotifierProvider.value(
      value: TestPageNotifier(section: section, userService: us),
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
              phrase: tn.section
                  .phrases[min(tn.index, tn.section.phrases.length - 1)],
              selection: tn.randomSelections(context),
              onNext: (choiceIdx) async {
                // test finish
                await tn.next(context, choiceIdx);

                if (tn.index == tn.section.phrases.length) {
                  await tn.finishTest();
                  await _goResultPage(context, tn.stats);
                }
              }),
        ),
      ),
    );
  }
}
