// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:wr_app/model/conversation.dart';

import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';

/// フレーズ詳細ページ
///
/// ## プロトタイプ
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134>
class LessonPhrasesDetailPage extends StatelessWidget {
  const LessonPhrasesDetailPage({@required this.phrase});
  final Phrase phrase;

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
                    fontSize: 30,
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
                  fontSize: 30,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
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
            child: FloatingActionButton(
              heroTag: '1',
              child: const Text('1'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              heroTag: '2',
              child: const Text('2'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              heroTag: '3',
              child: const Text('3'),
              onPressed: () {
                AssetsAudioPlayer()
                  ..open(phrase.audioPath)
                  ..play();
              },
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              heroTag: '4',
              child: const Text('4'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              heroTag: '5',
              child: const Text('5'),
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
              child: Text(
                conversation.english,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // アバター・日本語訳
          Container(
            transform: Matrix4.translationValues(0, -10, 0),
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
                  child: Text(conversation.japanese),
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
