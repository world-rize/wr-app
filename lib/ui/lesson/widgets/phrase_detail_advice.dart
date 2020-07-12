// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/lesson/widgets/voice_player.dart';

/// ワンポイントアドバイス
class PhraseDetailAdvice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<VoicePlayer>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                I.of(context).onePointAdvice,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(player.phrase.advice['ja']),
            ),
          ],
        ),
      ),
    );
  }
}
