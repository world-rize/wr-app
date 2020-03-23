// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:wr_app/model/conversation.dart';

import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';

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
  bool _isPlaying = false;
  List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];
  double _currentPlaybackSpeed = 1;
  AudioPlayer _player;
  AudioCache _cache;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer()
      ..onPlayerStateChanged.listen((AudioPlayerState state) {
        setState(() {
          _isPlaying = state == AudioPlayerState.PLAYING;
        });
      });
    _cache = AudioCache(fixedPlayer: _player)..load(phrase.audioPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Phrase Detail'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: _createPhraseSample(),
            ),
            Expanded(
              flex: 3,
              child: _createOnePointAdvice(),
            ),
            Expanded(
              flex: 2,
              child: _createButtonArea(),
            ),
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
                phrase.japanese,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              // height: 300,
              child: PhraseSampleView(sample: phrase.sample),
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
                'One Point Advice',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(phrase.advice),
            ),
          ],
        ),
      ),
    );
  }

  /// 下部ボタン
  Widget _createButtonArea() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // 吹き出しボタン
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: '1',
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
              heroTag: '2',
              child: const Icon(
                Icons.star,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
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
                  _cache.play(phrase.audioPath);
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
                  fontSize: 30,
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
              heroTag: '5',
              child: const Icon(
                Icons.record_voice_over,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

/// フレーズ例
class PhraseSampleView extends StatelessWidget {
  const PhraseSampleView({@required this.sample});
  final PhraseSample sample;

  /// "()" で囲まれた部分を太字にします
  /// 例 "abc(def)g" -> "abc<strong>def</strong>g"
  Text _boldify(String text, TextStyle basicStyle) {
    final _children = <InlineSpan>[];
    // not good code
    text.splitMapJoin(RegExp(r'\((.*)\)'), onMatch: (match) {
      _children.add(TextSpan(
        text: match.group(1),
        style: TextStyle(fontWeight: FontWeight.bold).merge(basicStyle),
      ));
      return '';
    }, onNonMatch: (plain) {
      _children.add(TextSpan(
        text: plain,
        style: basicStyle,
      ));
      return '';
    });

    return Text.rich(TextSpan(children: _children));
  }

  Widget _createMessageView(Conversation conversation, {bool primary = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            primary ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // 英語メッセージ
          Container(
            padding: const EdgeInsets.all(10),
            width: 350,
            decoration: BoxDecoration(
              color: primary ? Colors.lightBlue : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _boldify(
                  conversation.english,
                  TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  )),
            ),
          ),
          // アバター・日本語訳
          Container(
            // transform: Matrix4.translationValues(0, -10, 0),
            child: Row(
              textDirection: primary ? TextDirection.rtl : TextDirection.ltr,
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    conversation.avatarUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // child: Text(conversation.japanese),
                  child: _boldify(
                    conversation.japanese,
                    TextStyle(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _createMessageView(sample.content[0]),
        _createMessageView(sample.content[1], primary: true),
        _createMessageView(sample.content[2]),
      ],
    );
  }
}
