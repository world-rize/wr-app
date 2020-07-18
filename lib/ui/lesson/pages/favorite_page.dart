// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/ui/lesson/pages/section_list_page.dart';

/// Lesson > index > favorites
/// - favorites page of lesson
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<LessonNotifier>(context);

    return FutureBuilder<List<Phrase>>(
      future: notifier.favoritePhrases(),
      builder: (_, res) {
        return SectionListPage(
          section: Section(
            title: 'favorite',
            phrases: res.hasData ? res.data : [],
          ),
        );
      },
    );
  }
}
