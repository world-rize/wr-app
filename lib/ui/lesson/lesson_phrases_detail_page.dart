// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:wr_app/model/phrase.dart';

class LessonPhrasesDetailPage extends StatelessWidget {
  const LessonPhrasesDetailPage({@required this.phrase});
  final Phrase phrase;

  // TODO(yoshiki301): 実装
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
              height: 400,
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
          ],
        ),
      ),
    );
  }
}
