import 'package:flutter/cupertino.dart';
import 'package:wr_app/domain/voice_accent.dart';

/// VoiceAccentから国旗の旗を含んだ[Image]を作る
class LocaleToImage extends StatelessWidget {
  const LocaleToImage({
    @required this.voiceAccent,
    this.height,
    this.width,
    this.fit,
  });

  final VoiceAccent voiceAccent;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/locale_${_voiceAccentToAssetsString(voiceAccent)}.png',
      height: height,
      width: width,
      fit: fit,
    );
  }
}

String _voiceAccentToAssetsString(VoiceAccent va) {
  return {
    VoiceAccent.japanese: 'jp-jp',
    VoiceAccent.americanEnglish: 'en-us',
    VoiceAccent.australiaEnglish: 'en-au',
    VoiceAccent.britishEnglish: 'en-uk',
    VoiceAccent.indianEnglish: 'en-in',
  }[va];
}
