// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/phrase_example_card.dart';

/// フレーズ詳細画面
class PhraseDetailPageView extends StatelessWidget {
  const PhraseDetailPageView({@required this.phrase});

  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    final exampleView = Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PhraseExampleCard(
              phrase: phrase,
            ),
          ],
        ),
      ),
    );

    final adviceView = Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                I.of(context).onePointAdvice,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(phrase.advice['ja'],
                  style: Theme.of(context).primaryTextTheme.bodyText2),
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          exampleView,
          adviceView,
        ],
      ),
    );
  }
}
