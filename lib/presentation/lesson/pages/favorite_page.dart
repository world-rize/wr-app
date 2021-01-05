// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_card.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

import '../../lesson_notifier.dart';

/// Lesson > index > favorites
/// - favorites page of lesson
class FavoritePage extends StatelessWidget {
  Future<List<Tuple2<Phrase, bool>>> _getFavorites(BuildContext context) async {
    final un = Provider.of<UserNotifier>(context);
    final ln = Provider.of<LessonNotifier>(context);

    final phrases = await ln.getFavoritePhrases(un.user);
    final List<Tuple2<Phrase, bool>> tuples = [];
    Future.forEach(phrases, (element) async {
      final exist = await ln.existPhraseInFavoriteList(
        user: un.user,
        phraseId: element.id,
      );
      tuples.add(Tuple2(element, exist));
    });
    return tuples;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final un = Provider.of<UserNotifier>(context);
    final ln = Provider.of<LessonNotifier>(context);

    final favoritePhraseCards = FutureBuilder<List<Tuple2<Phrase, bool>>>(
        future: _getFavorites(context),
        builder: (_, res) {
          if (!res.hasData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (res.hasError) {
            InAppLogger.error(res.error);
          }

          final section = Section(
            id: 'favorite',
            title: I
                .of(context)
                .favoritePageTitle,
            phrases: res.data.map((e) => e.item1).toList(),
          );

          return Column(
            children: res.data.indexedMap((index, phrase) {
              return PhraseCard(
                phrase: phrase.item1,
                favorite: phrase.item2,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          SectionPage(
                            section: section,
                            index: index,
                          ),
                    ),
                  );
                },
                onFavorite: () {
                  ln.favoritePhrase(
                    phraseId: phrase.item1.id,
                    favorite: !phrase.item2,
                    user: un.user,
                  );
                },
              );
            }).toList(),
          );
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          I
              .of(context)
              .favoritePageTitle,
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
