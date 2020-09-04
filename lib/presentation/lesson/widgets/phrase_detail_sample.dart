// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';

import '../notifier/voice_player.dart';
import '../widgets/phrase_example.dart';

class PhraseDetailSample extends StatelessWidget {
  PhraseDetailSample({@required this.phrase});

  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final voicePlayer = Provider.of<VoicePlayer>(context);
    final lessonNotifier = Provider.of<LessonNotifier>(context);
    final showTranslation = lessonNotifier.getShowTranslation();

    final header = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              phrase.title['en'],
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
              phrase.title['ja'],
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
              example: phrase.example,
              showTranslation: showTranslation,
              onMessageTapped: (message, index) {
                voicePlayer.play(message);
              },
            ),
          ],
        ),
      ),
    );
  }
}