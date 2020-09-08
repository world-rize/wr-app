// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

// import 'package:getflutter/components/carousel/gf_carousel.dart';
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

class Card {
  Card(this.word, this.translation);

  String word;
  String translation;
}

class _FlashCardState extends State<FlashCard> {
  bool _flipped;

  PageController pageController;

  @override
  void initState() {
    super.initState();
    _flipped = false;
  }

  @override
  Widget build(BuildContext context) {
    final h1 = Theme.of(context).textTheme.headline2;
    final cards = <NotePhrase>[];
    final user = context.select((UserNotifier un) => un.getUser());
    final flashCardNotifier = Provider.of<FlashCardNotifier>(context);
    final nowSelectedNoteId =
        context.select((NoteNotifier nn) => nn.nowSelectedNoteId);
    final note = nowSelectedNoteId == null
        ? user.notes['default']
        : user.notes.values
            .firstWhere((element) => element.id == nowSelectedNoteId);

    final widget = GFCarousel(
      autoPlay: false,
      autoPlayInterval: const Duration(seconds: 3),
      enableInfiniteScroll: false,
      // FIXME: phrasesに順番の概念がないので毎回ランダムになるリスト型にする必要がある
      items: note.phrases.values.toList().asMap().entries.map((entry) {
        final index = entry.key;
        final phrase = entry.value;
        return GestureDetector(
          onTap: () {
            setState(() {
              _flipped = !_flipped;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShadowedContainer(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(8),
                key: GlobalKey(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.topCenter,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 4),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    _flipped ? phrase.word : phrase.translation,
                    style: h1,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
    pageController = widget.pageController;
    return widget;
  }
}
