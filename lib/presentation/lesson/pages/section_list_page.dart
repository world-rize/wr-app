// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';

import '../widgets/phrase_card.dart';

/// フレーズ一覧ページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469136>
class SectionListPage extends StatelessWidget {
  // TODO: PhraseListPageっぽい
  const SectionListPage({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final ln = Provider.of<LessonNotifier>(context);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          section.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // TODO(somebody): per-page scroll physics
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // ヘッダ
            // header,
            // フレーズ一覧
            ...section.phrases.indexedMap((index, phrase) {
              return FutureBuilder(
                  future: ln.existPhraseInFavoriteList(
                      user: un.user, phraseId: phrase.id),
                  builder: (context, snapshot) {
                    var favorite = false;
                    if (snapshot.hasData) {
                      favorite = snapshot.data;
                    }

                    return PhraseCard(
                      phrase: phrase,
                      favorite: favorite,
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
                      onFavorite: () async {
                        await ln.favoritePhrase(
                          phraseId: phrase.id,
                          favorite: !favorite,
                          user: un.user,
                        );
                      },
                    );
                  });
            }).toList(),
          ],
        ),
      ),
    );
  }
}
