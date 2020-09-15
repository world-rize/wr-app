// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/logger.dart';

/// NotePhrase を表示するウィジェット
class FlashCard extends StatefulWidget {
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  /// 裏側か
  bool _flipped;

  @override
  void initState() {
    super.initState();
    _flipped = false;
  }

  Widget _createFlashCardContainer(NotePhrase phrase) {
    final nn = context.watch<NoteNotifier>();
    final currentNote = nn.currentNote;
    if (currentNote == null) {
      return const SizedBox.shrink();
    }

    final achievedButton = IconButton(
      icon: const Icon(
        Icons.check_box,
        size: 24,
        color: Colors.green,
      ),
      onPressed: () {
        nn.achievePhrase(noteId: currentNote.id, phraseId: phrase.id);
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
          color: backgroundColor,
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
                  if (!_flipped)
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
  Widget build(BuildContext context) {
    final fn = Provider.of<FlashCardNotifier>(context);
    final phrases = fn.notePhrases;
    InAppLogger.debug(
        phrases.map((p) => '(${p.japanese} -> ${p.english}').join(', '));

    final flashCard = GFCarousel(
      viewportFraction: 0.9,
      aspectRatio: 4 / 3,
      autoPlay: false,
      autoPlayInterval: const Duration(seconds: 3),
      enableInfiniteScroll: false,
      items: phrases.map(_createFlashCardContainer).toList(),
      initialPage: fn.nowPhraseIndex,
    );

    Provider.of<FlashCardNotifier>(context).pageController =
        flashCard.pageController;

    return flashCard;
  }
}
