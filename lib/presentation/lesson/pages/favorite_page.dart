// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/phrase_page_view/index.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_card.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';

import '../notifier/lesson_notifier.dart';

/// Lesson > index > favorites
/// - favorites page of lesson
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final userNotifier = Provider.of<UserNotifier>(context);
    final lessonNotifier = Provider.of<LessonNotifier>(context);

    final favoritePhraseCards = FutureBuilder<List<Phrase>>(
        future: lessonNotifier.favoritePhrases(userNotifier.user),
        builder: (_, res) {
          if (!res.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            );
          }

          final section = Section(
            id: 'favorite',
            title: I.of(context).favoritePageTitle,
            phrases: res.data,
          );

          return Column(
            children: section.phrases.indexedMap((index, phrase) {
              return PhraseCard(
                phrase: phrase,
                favorite:
                    userNotifier.existPhraseInFavoriteList(phraseId: phrase.id),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PhrasePageView(
                        section: section,
                        index: index,
                      ),
                    ),
                  );
                },
                onFavorite: () {
                  final favorite = userNotifier.existPhraseInFavoriteList(
                      phraseId: phrase.id);
                  userNotifier.favoritePhrase(
                      phraseId: phrase.id, favorite: !favorite);
                },
              );
            }).toList(),
          );
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          I.of(context).favoritePageTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            favoritePhraseCards,
          ],
        ),
      ),
    );
  }
}
