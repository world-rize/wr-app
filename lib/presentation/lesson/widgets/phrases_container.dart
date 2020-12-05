import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_card.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';

// Sectionタブを展開した時に表示されるもの
class PhrasesContainer extends StatelessWidget {
  final Section section;

  const PhrasesContainer({@required this.section});

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final ln = Provider.of<LessonNotifier>(context);

    final phrasesView = Column(
      children: <Widget>[
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
    );

    return phrasesView;
  }
}