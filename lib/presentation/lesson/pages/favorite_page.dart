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

import '../../lesson_notifier.dart';

/// Lesson > index > favorites
/// - favorites page of lesson
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final un = Provider.of<UserNotifier>(context);
    final ln = Provider.of<LessonNotifier>(context);

    final favoritePhraseCards = FutureBuilder<List<Tuple2<Phrase, bool>>>(
        future: ln.getFavoritePhrases(un.user).then((value) async {
          return Future.forEach(value, (element) async {
            return Tuple2(
                element,
                await ln.existPhraseInFavoriteList(
                    user: un.user, phraseId: element.id));
          });
        }),
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
            phrases: res.data.map((e) => e.item1),
          );

          return Column(
            children: res.data.indexedMap((index, phrase) {
              return PhraseCard(
                phrase: phrase.item1,
                favorite: phrase.item2,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SectionPage(
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
