// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';

import './section_list_page.dart';
import '../notifier/lesson_notifier.dart';

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
            id: 'favorite',
            title: 'お気に入り',
            phrases: res.hasData ? res.data : [],
          ),
        );
      },
    );
  }
}
