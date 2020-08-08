// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/presentation/user_notifier.dart';

import '../notifier/voice_player.dart';

/// 下部ボタン
class PhraseDetailButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<VoicePlayer>(context);
    final lesson = Provider.of<LessonNotifier>(context);
    final notifier = Provider.of<UserNotifier>(context);
    final favorite = notifier.getUser().isFavoritePhrase(player.phrase);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // 吹き出しボタン
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'Japanese',
              child: Icon(
                Icons.message,
                color: lesson.getShowTranslation()
                    ? Colors.lightBlueAccent
                    : Colors.grey,
              ),
              onPressed: lesson.toggleShowTranslation,
            ),
          ),
          // お気に入りボタン
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'Favorite',
              child: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () {
                notifier.favoritePhrase(
                    phraseId: player.phrase.id, value: !favorite);
              },
            ),
          ),
          // 再生ボタン
          Expanded(
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                heroTag: '3',
                child: Icon(
                  player.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.orangeAccent,
                  size: 40,
                ),
                onPressed: () async {
                  await player.toggle();
                }),
          ),
          // 再生速度
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: '4',
              child: Text(
                player.speed.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onPressed: player.toggleSpeed,
            ),
          ),
          // 発音
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'Country',
              child: Image.asset(
                'assets/icon/locale_${player.locale}.png',
              ),
              onPressed: player.toggleLocale,
            ),
          ),
        ],
      ),
    );
  }
}
