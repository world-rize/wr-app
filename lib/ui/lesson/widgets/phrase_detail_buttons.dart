// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/preferences.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/widgets/voice_player.dart';

/// 下部ボタン
class PhraseDetailButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<VoicePlayer>(context);
    // TODO(?): データに依存しない
    final preferences = Provider.of<PreferencesStore>(context);
    final userStore = Provider.of<UserStore>(context);
    final favorite = userStore.favorited(player.phrase);

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
                color: preferences.showTranslation
                    ? Colors.lightBlueAccent
                    : Colors.grey,
              ),
              onPressed: preferences.toggleShowTranslation,
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
                userStore.callFavoritePhrase(
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
              onPressed: player.toggle,
            ),
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
