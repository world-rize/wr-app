// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/voice_accent.dart';
import 'package:wr_app/presentation/note/widgets/national_flags.dart';
import 'package:wr_app/presentation/note/widgets/pitch_slider.dart';
import 'package:wr_app/presentation/voice_player.dart';

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
          Container(padding: EdgeInsets.all(8), child: Text('Play Speed')),
          Padding(
            padding: EdgeInsets.all(8),
            child: PitchSlider(
              pitch: vp.speed,
              pitches: const [0.8, 0.9, 1.0, 1.1, 1.2],
              onChanged: (double p) {
                vp.setSpeed(p);
              },
            ),
          ),

          Text('Accent'),
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
        ],
      ),
    );
  }
}
