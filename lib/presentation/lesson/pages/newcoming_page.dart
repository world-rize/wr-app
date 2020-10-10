// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';

import './phrase_list_page.dart';
import '../notifier/lesson_notifier.dart';

/// Lesson > index > new coming
class NewComingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<LessonNotifier>(context);

    return FutureBuilder<List<Phrase>>(
      future: notifier.newComingPhrases(),
      builder: (_, res) {
        return PhraseListPage(
          section: Section(
            id: 'newcoming',
            title: I.of(context).newComingPageTitle,
            phrases: res.hasData ? res.data : [],
          ),
        );
      },
    );
  }
}
