// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/notifier/voice_player.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_detail_buttons.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/toast.dart';

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
  _SectionDetailPageState({
    @required this.section,
    @required this.index,
  });

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
    final userNotifier = Provider.of<UserNotifier>(context);
    final phrase = section.phrases[index];
    final existNotes = userNotifier.existPhraseInNotes(phraseId: phrase.id);

    final _addNotesButton = IconButton(
      icon: Icon(existNotes ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () {
        userNotifier.addPhraseToPhraseList(
          listId: 'default',
          phrase: section.phrases[index],
        );
      },
    );

    return ChangeNotifierProvider<VoicePlayer>.value(
      value: VoicePlayer(
        onError: NotifyToast.error,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            I.of(context).phraseDetailTitle,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [_addNotesButton],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (i) {
            setState(() => index = i);
          },
          children: section.phrases
              .map((phrase) => PhrasesDetailPage(phrase: phrase))
              .toList(),
        ),
        // controller
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            child: PhraseDetailButtons(phrase: phrase),
          ),
        ),
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
    final userNotifier = Provider.of<UserNotifier>(context);
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
          ],
        ),
      ),
    );
  }
}
