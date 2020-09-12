// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/voice_accent.dart';
import 'package:wr_app/presentation/lesson/notifier/voice_player.dart';
import 'package:wr_app/presentation/note/widgets/national_flags.dart';
import 'package:wr_app/presentation/note/widgets/pitch_slider.dart';

class PhraseDetailSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vp = Provider.of<VoicePlayer>(context);
    // TODO: get from user
    final availableLocales =
        VoiceAccent.values.where((l) => l != VoiceAccent.japanese).toList();

    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('再生速度'),
          // pitch slider
          Padding(
            padding: EdgeInsets.all(8),
            child: PitchSlider(
              pitch: 1,
              pitches: const [0.5, 0.75, 1.0, 1.5],
              onChanged: (p) {},
            ),
          ),

          Text('言語'),
          // accent
          Padding(
            padding: const EdgeInsets.all(8),
            child: NationalFlags(
              locale: vp.locale,
              locales: availableLocales,
              onChanged: (l) {
                vp.setLocale(l);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8),
            child: PitchSlider(
              pitch: vp.speed,
              pitches: const [0.5, 0.75, 1.0, 1.5],
              onChanged: (double p) {
                vp.setSpeed(p);
              },
            ),
          ),

          Spacer(),

          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
