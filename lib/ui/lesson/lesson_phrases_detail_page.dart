// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_example.dart';

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

  // State Options
  static List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];
  static List<String> pronunciations = ['en-us', 'en-uk', 'en-au'];

  final Phrase phrase;

  // State
  bool _isPlaying = false;
  double _currentPlaybackSpeed = 1;
  String _currentVoiceType = pronunciations[0];
  AudioPlayer _player;
  AudioCache _cache;

  String voicePath() {
    final mainPhrase = phrase.example.value[1];
    if (mainPhrase.assets?.voice?.containsKey(_currentVoiceType) ?? false) {
      return mainPhrase.assets.voice[_currentVoiceType];
    } else {
      return 'voice_sample.mp3';
    }
  }

  void showErrorDialog(Error e) {
    print(e);

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('エラー'),
        content: Text('音声の再生に失敗しました\n$e'),
        actions: <Widget>[
          CupertinoButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer()
      ..onPlayerStateChanged.listen((AudioPlayerState state) {
        setState(() {
          _isPlaying = state == AudioPlayerState.PLAYING;
        });
      });

    _cache = AudioCache(fixedPlayer: _player)..load(voicePath());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Phrase Detail'),
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
          children: <Widget>[
            ListTile(
              title: Text(
                phrase.title['ja'],
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            PhraseSampleView(example: phrase.example),
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
                'One Point Advice',
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
              child: const Icon(
                Icons.message,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            ),
          ),
          // お気に入りボタン
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'Favorite',
              child: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.blueAccent,
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
                _isPlaying ? Icons.stop : Icons.play_arrow,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (!_isPlaying) {
                  _cache.play(voicePath()).catchError(showErrorDialog);
                } else {
                  _cache.fixedPlayer.stop();
                }
              },
            ),
          ),
          // 再生速度
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: '4',
              child: Text(
                _currentPlaybackSpeed.toString(),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                final _index = playbackSpeeds.indexOf(_currentPlaybackSpeed);
                final _nextSpeed =
                    playbackSpeeds[(_index + 1) % playbackSpeeds.length];
                _cache.fixedPlayer.setPlaybackRate(playbackRate: _nextSpeed);
                setState(() {
                  _currentPlaybackSpeed = _nextSpeed;
                });
              },
            ),
          ),
          // 発音
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'Country',
              child: Text(
                _currentVoiceType,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                final _index = pronunciations.indexOf(_currentVoiceType);
                final _nextPron =
                    pronunciations[(_index + 1) % pronunciations.length];
                setState(() {
                  _currentVoiceType = _nextPron;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
