// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/presentation/note/widgets/flash_card_controller.dart';
import 'package:wr_app/presentation/note/widgets/flash_card_widget.dart';

class FlashCardPage extends StatelessWidget {
  FlashCardPage({@required this.note});

  Note note;

  @override
  Widget build(BuildContext context) {
    // TODO: Provider FlashCardNotifier
    return Provider<FlashCardNotifier>(
      create: (_) => FlashCardNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ノート名'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlashCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlashCardController(),
            ),
          ],
        ),
      ),
    );
  }
}
