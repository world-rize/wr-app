// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/phrase.dart';

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
                phrase.japanese,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: _createPhraseSampleConversation(),
            ),
            // test
            MaterialButton(
              onPressed: () {
                final _player = AssetsAudioPlayer()
                  ..open(phrase.audioPath)
                  ..play();
              },
              child: Text(phrase.audioPath),
            )
          ],
        ),
      ),
    );
  }

  // TODO(yoshiki301): 実装
  /// 例の会話部分
  Widget _createPhraseSampleConversation() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'dummy',
            ));
      },
      itemCount: 4,
    );
  }

  Widget _createOnePointAdvice() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "One Point Advice",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButtonArea(){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FloatingActionButton(
              child: const Text('1'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              child: const Text('2'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              child: const Text('3'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              child: const Text('4'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              child: const Text('5'),
              onPressed: () {},
            ),
          ),
        ],
      )
    );
  }

  
}
