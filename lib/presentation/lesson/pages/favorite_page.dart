// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';

import './section_list_page.dart';
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
        future: lessonNotifier.favoritePhrases(userNotifier.getUser()),
        builder: (_, res) {
          if (!res.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            );
          }

          final section = Section(
            id: 'favorite',
            title: 'お気に入り',
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
                      builder: (_) => SectionDetailPage(
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
        title: const Text(
          'お気に入り',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('グループ, 並び替え機能(TODO)'),
            ),
            favoritePhraseCards,
          ],
        ),
      ),
    );
  }
}
