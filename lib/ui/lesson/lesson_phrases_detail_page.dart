// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_example.dart';

import 'package:wr_app/ui/lesson/widgets/voice_player.dart';

/// フレーズ詳細ページ
///
/// ## プロトタイプ
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134>
class LessonPhrasesDetailPage extends StatefulWidget {
  const LessonPhrasesDetailPage({@required this.phrase});
  final Phrase phrase;

  @override
  _LessonPhrasesDetailPageState createState() =>
      _LessonPhrasesDetailPageState(phrase: phrase);
}

class _LessonPhrasesDetailPageState extends State<LessonPhrasesDetailPage> {
  _LessonPhrasesDetailPageState({@required this.phrase});

  final Phrase phrase;

  // State
  bool _showTranslation = false;

  VoicePlayer player;

  @override
  void initState() {
    super.initState();

    player = VoicePlayer(
      phrase: phrase,
      onError: (e) {
        print(e);
        showErrorDialog(e);
      },
    );
  }

  void showErrorDialog(dynamic e) {
    print(e.toString());

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).error),
        content: Text('$e'),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I.of(context).ok),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          I.of(context).phraseDetailTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _createPhraseSample(),
            _createOnePointAdvice(),
            _createButtonArea(),
          ],
        ),
      ),
    );
  }

  /// フレーズの例の画面
  Widget _createPhraseSample() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Text(
                phrase.title['en'],
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                phrase.title['ja'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black38,
                ),
              ),
            ),
            PhraseSampleView(
              example: phrase.example,
              showTranslation: _showTranslation,
              onMessageTapped: (message, index) {
                player.play(message);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ワンポイントアドバイス
  Widget _createOnePointAdvice() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                I.of(context).onePointAdvice,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(phrase.advice['ja']),
            ),
          ],
        ),
      ),
    );
  }

  /// 下部ボタン
  Widget _createButtonArea() {
    final userStore = Provider.of<UserStore>(context);
    final favorite = userStore.user.favorites.containsKey(phrase.id) &&
        userStore.user.favorites[phrase.id];

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
                color: _showTranslation ? Colors.lightBlueAccent : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _showTranslation = !_showTranslation;
                });
              },
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
                    phraseId: phrase.id, value: !favorite);
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
                style: TextStyle(
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
