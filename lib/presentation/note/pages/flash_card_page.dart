// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/widgets/flash_card_controller.dart';
import 'package:wr_app/presentation/note/widgets/flash_card_widget.dart';

class FlashCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nn = context.watch<NoteNotifier>();
    final note = nn.currentNote;
    final phrases = note.phrases
        .where((p) => p.japanese.isNotEmpty && p.english.isNotEmpty)
        .toList();

    return ChangeNotifierProvider<FlashCardNotifier>(
      create: (_) => FlashCardNotifier(
        noteId: note.id,
        notePhrases: phrases,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Column(
          children: [
            const Spacer(),
            // 単語が空の時はフラッシュカードを表示しない
            if (phrases.isEmpty)
              const SizedBox.shrink()
            else
              Padding(
                padding: const EdgeInsets.all(8),
                child: FlashCard(
                  noteId: note.id,
                  notePhrases: phrases,
                  onCardTap: (phrase) {
                    nn.achievePhrase(noteId: note.id, phraseId: phrase.id);
                  },
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: FlashCardController(),
            ),
          ],
        ),
      ),
    );
  }
}
