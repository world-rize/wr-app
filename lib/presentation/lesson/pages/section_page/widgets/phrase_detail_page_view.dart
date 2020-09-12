// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/phrase_example_messages_view.dart';

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
                  fontSize: 20,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(phrase.advice['ja']),
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
