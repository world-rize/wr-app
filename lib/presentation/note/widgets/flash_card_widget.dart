// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// NotePhrase を表示するウィジェット
class FlashCard extends StatelessWidget {
  FlashCard({
    @required this.noteId,
    @required this.notePhrases,
    @required this.onCardTap,
  });

  final String noteId;
  final List<NotePhrase> notePhrases;
  final Function(NotePhrase) onCardTap;

  Widget _createFlashCardContainer(BuildContext context, NotePhrase phrase) {
    final fn = Provider.of<FlashCardNotifier>(context, listen: false);
    final achievedButton = IconButton(
      icon: const Icon(
        Icons.check_box,
        size: 24,
        color: Colors.green,
      ),
      onPressed: () {
        onCardTap(phrase);
      },
    );
    final playButton = IconButton(
      icon: const Icon(
        Icons.volume_up,
        size: 24,
        color: Colors.green,
      ),
      onPressed: () {
        fn.play();
      },
    );
    final backgroundColor = Theme.of(context).backgroundColor;
    final body1 = Theme.of(context).primaryTextTheme.bodyText1;

    return GestureDetector(
      onTap: () {
        Provider.of<FlashCardNotifier>(context, listen: false).flipCard();
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
                      fn.showJapanese ? phrase.japanese : phrase.english,
                      style: body1,
                    ),
                  ),
                  if (fn.showJapanese)
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: achievedButton,
                    ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: playButton,
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

    final flashCard = GFCarousel(
      viewportFraction: 0.9,
      aspectRatio: 4 / 3,
      autoPlay: false,
      autoPlayInterval: const Duration(seconds: 3),
      enableInfiniteScroll: false,
      items: fn.notePhrases
          .map((e) => _createFlashCardContainer(context, e))
          .toList(),
      initialPage: fn.nowPhraseIndex,
    );

    Provider.of<FlashCardNotifier>(context).pageController =
        flashCard.pageController;

    return flashCard;
  }
}
