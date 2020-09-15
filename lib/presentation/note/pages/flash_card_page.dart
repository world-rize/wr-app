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

    return ChangeNotifierProvider<FlashCardNotifier>(
      create: (_) => FlashCardNotifier(note: note),
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Column(
          children: [
            const Spacer(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: FlashCard(),
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
