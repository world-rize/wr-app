// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';

import '../widgets/phrase_detail_advice.dart';
import '../widgets/phrase_detail_sample.dart';

/// Lesson > index > lesson > sections > phrase_detail_page
/// - phrase detail page
class PhrasesDetailPage extends StatelessWidget {
  const PhrasesDetailPage({@required this.phrase});

  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          PhraseDetailSample(phrase: phrase),
          PhraseDetailAdvice(text: phrase.advice['ja']),
        ],
      ),
    );
  }
}