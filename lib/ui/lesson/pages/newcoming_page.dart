// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/ui/lesson/pages/section_list_page.dart';

/// Lesson > index > new coming
class NewComingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<LessonNotifier>(context);

    return FutureBuilder<List<Phrase>>(
      future: notifier.newComingPhrases(),
      builder: (_, res) {
        if (res.hasData) {
          return SectionListPage(
            section: Section(
              title: 'new coming',
              phrases: res.data,
            ),
          );
        } else {
          return const Text('loading');
        }
      },
    );
  }
}
