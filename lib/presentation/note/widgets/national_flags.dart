// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/voice_accent.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';

Map<VoiceAccent, String> _mapVoiceAccentString = {
  VoiceAccent.americanEnglish: 'en-us',
  VoiceAccent.australiaEnglish: 'en-au',
  VoiceAccent.britishEnglish: 'en-uk',
  VoiceAccent.indianEnglish: 'en-in',
};

/// ```dart
/// Padding(
///   padding: const EdgeInsets.all(8),
///   child: NationalFlags(
///     locale: VoiceAccent.americanEnglish,
///     locales: const [
///       VoiceAccent.americanEnglish,
///       VoiceAccent.britishEnglish,
///       VoiceAccent.australiaEnglish,
///       VoiceAccent.indianEnglish,
///     ],
///     onChanged: (VoiceAccent voiceAccent) {
///       Provider.of<FlashCardNotifier>(context, listen: false)
///         .setVoiceAccent(voiceAccent);
///     },
///   ),
/// ),
/// ```
///
/// 国旗
class NationalFlags extends StatelessWidget {
  NationalFlags({
    @required this.locales,
    @required this.locale,
    @required this.onChanged,
  });

  final List<VoiceAccent> locales;
  final VoiceAccent locale;
  final Function(VoiceAccent) onChanged;

  @override
  Widget build(BuildContext context) {
    Widget _flagCard(VoiceAccent voiceAccent) => Image.asset(
          'assets/icon/locale_${_mapVoiceAccentString[voiceAccent]}.png',
          height: 30,
          width: 50,
          fit: BoxFit.fill,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: locales
          .map((l) => GestureDetector(
                onTap: () {
                  onChanged(l);
                },
                child: Container(
                  decoration:
                      Provider.of<FlashCardNotifier>(context, listen: false)
                                  .voiceAccent ==
                              l
                          ? BoxDecoration(border: Border.all(width: 3))
                          : null,
                  child: _flagCard(l),
                ),
              ))
          .toList(),
    );
  }
}
