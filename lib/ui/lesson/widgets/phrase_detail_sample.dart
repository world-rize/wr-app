// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_example.dart';
import 'package:wr_app/ui/lesson/widgets/voice_player.dart';

class PhraseDetailSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final player = Provider.of<VoicePlayer>(context);
    final lesson = Provider.of<LessonNotifier>(context);
    final showTranslation = lesson.getShowTranslation();

    final header = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              player.phrase.title['en'],
              style: TextStyle(
                fontSize: 20,
                color: theme.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              player.phrase.title['ja'],
              style: TextStyle(
                fontSize: 16,
                color: theme.accentColor,
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            header,
            PhraseSampleView(
              example: player.phrase.example,
              showTranslation: showTranslation,
              onMessageTapped: (message, index) {
                player.play(message);
              },
            ),
          ],
        ),
      ),
    );
  }
}
