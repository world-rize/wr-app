// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// NotePhrase を表示するウィジェット
class FlashCard extends StatefulWidget {
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  /// 裏側か
  bool _flipped;

  Widget _createFlashCardContainer(NotePhrase phrase) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final noteId = Provider.of<NoteNotifier>(context).nowSelectedNoteId;
    final note = userNotifier.getUser().notes[noteId];
    if (note == null) {
      return const SizedBox.shrink();
    }

    final achieved =
        note.phrases.map((phrase) => phrase.id).contains(phrase.id);
    final achievedButton = IconButton(
      icon: Icon(
        achieved ? Icons.favorite : Icons.favorite_border,
        size: 24,
      ),
      onPressed: () {
        userNotifier.achievePhrase(noteId: noteId, phraseId: phrase.id);
      },
    );
    final backgroundColor = Theme.of(context).backgroundColor;
    final body1 = Theme.of(context).primaryTextTheme.bodyText1;

    return GestureDetector(
      onTap: () {
        setState(() {
          _flipped = !_flipped;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ShadowedContainer(
          color: _flipped ? backgroundColor : Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(8),
            key: GlobalKey(),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      _flipped ? phrase.english : phrase.japanese,
                      style: body1,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: achievedButton,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _flipped = false;
  }

  @override
  Widget build(BuildContext context) {
    final fn = Provider.of<FlashCardNotifier>(context);

    final flashCard = GFCarousel(
      viewportFraction: 0.9,
      aspectRatio: 4 / 3,
      autoPlay: false,
      autoPlayInterval: const Duration(seconds: 3),
      enableInfiniteScroll: false,
      // FIXME: phrasesに順番の概念がないので毎回ランダムになるリスト型にする必要がある
      items: fn.notePhrases.map(_createFlashCardContainer).toList(),
      initialPage: fn.nowPhraseIndex,
    );

    Provider.of<FlashCardNotifier>(context).pageController =
        flashCard.pageController;

    return flashCard;
  }
}
