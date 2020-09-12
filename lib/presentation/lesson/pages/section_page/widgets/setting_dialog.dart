// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/presentation/note/widgets/national_flags.dart';
import 'package:wr_app/presentation/note/widgets/pitch_slider.dart';

class PhraseDetailSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('プレイヤーの設定'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // pitch slider
          Padding(
            padding: EdgeInsets.all(8),
            child: PitchSlider(
              pitch: 1,
              pitches: const [0.5, 0.75, 1.0, 1.5],
              onChanged: (p) {},
            ),
          ),

          // accent
          Padding(
            padding: const EdgeInsets.all(8),
            child: NationalFlags(
              locale: 'en-us',
              locales: const ['en-us', 'en-uk', 'en-au', 'en-in'],
              onChanged: (l) {},
            ),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
