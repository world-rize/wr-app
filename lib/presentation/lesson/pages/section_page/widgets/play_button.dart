// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/lesson/notifier/voice_player.dart';

class PhrasePlayButton extends StatelessWidget {
  const PhrasePlayButton({
    @required this.onPressed,
  });

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          heroTag: 'play',
          child: Icon(
            context.read<VoicePlayer>().isPlaying
                ? Icons.pause
                : Icons.play_arrow,
            color: Colors.white,
            size: 40,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
