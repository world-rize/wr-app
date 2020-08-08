// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';

import './phrase_detail_page.dart';
import '../widgets/phrase_widget.dart';

class SectionDetailPage extends StatefulWidget {
  const SectionDetailPage({@required this.section, @required this.index});

  final Section section;
  final int index;

  @override
  _SectionDetailPageState createState() => _SectionDetailPageState(
        section: section,
        index: index,
      );
}

class _SectionDetailPageState extends State<SectionDetailPage>
    with SingleTickerProviderStateMixin {
  _SectionDetailPageState({@required this.section, @required this.index});

  final Section section;
  PageController _pageController;
  int index;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          I.of(context).phraseDetailTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            index = index;
          });
        },
        children: section.phrases
            .map((phrase) => PhrasesDetailPage(phrase: phrase))
            .toList(),
      ),
    );
  }
}

/// フレーズ一覧ページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469136>
class SectionListPage extends StatelessWidget {
  const SectionListPage({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserNotifier>(context);
    final user = userStore.getUser();
    final primaryColor = Theme.of(context).primaryColor;

//    final header = Padding(
//      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//      child: GFListTile(
//        avatar: Text(
//          section.title,
//          style: const TextStyle(color: Colors.black, fontSize: 24),
//        ),
//      ),
//    );

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
              return PhraseCard(
                phrase: phrase,
                favorite: user.isFavoritePhrase(phrase),
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
                  final favorite = user.isFavoritePhrase(phrase);
                  userStore.favoritePhrase(
                      phraseId: phrase.id, value: !favorite);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
