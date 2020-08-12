// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/presentation/user_notifier.dart';

import '../notifier/voice_player.dart';

/// 下部ボタン
class PhraseDetailButtons extends StatelessWidget {
  PhraseDetailButtons({@required this.phrase});

  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    final voicePlayer = Provider.of<VoicePlayer>(context);
    final lessonNotifier = Provider.of<LessonNotifier>(context);
    final userNotifier = Provider.of<UserNotifier>(context);
    final favorite =
        userNotifier.existPhraseInFavoriteList(phraseId: phrase.id);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          // 吹き出しボタン
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'visibility',
            child: Icon(
              Icons.message,
              color: lessonNotifier.getShowTranslation()
                  ? Colors.lightBlueAccent
                  : Colors.grey,
            ),
            onPressed: lessonNotifier.toggleShowTranslation,
          ),
        ),
        // お気に入りボタン
        Expanded(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'favorite',
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: () {
              userNotifier.favoritePhrase(
                  phraseId: phrase.id, favorite: !favorite);
            },
          ),
        ),
        // 再生ボタン
        Expanded(
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'play',
              child: Icon(
                voicePlayer.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.orangeAccent,
                size: 40,
              ),
              onPressed: () async {
                if (voicePlayer.isPlaying) {
                  voicePlayer.pause();
                } else {
                  await voicePlayer.playAll(phrase: phrase);
                }
              }),
        ),
        // 再生速度
        Expanded(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'speed',
            child: Text(
              voicePlayer.speed.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            onPressed: voicePlayer.toggleSpeed,
          ),
        ),
        // 発音
        Expanded(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'locale',
            child: Image.asset(
              'assets/icon/locale_${voicePlayer.locale}.png',
            ),
            onPressed: voicePlayer.toggleLocale,
          ),
        ),
      ],
    );
  }
}
