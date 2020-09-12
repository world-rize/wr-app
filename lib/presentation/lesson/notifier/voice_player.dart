// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/voice_accent.dart';
import 'package:wr_app/util/logger.dart';

const Map<VoiceAccent, String> _voiceAccentMP3AssetsName = {
  VoiceAccent.americanEnglish: 'en-us',
  VoiceAccent.australiaEnglish: 'en-uk',
  VoiceAccent.britishEnglish: 'en-au',
  VoiceAccent.indianEnglish: 'en-in',
};

enum Visibility {
  all,
  // 英語
  englishOnly,
  // 日本語
  japaneseOnly,
}

/// phrase detail voice player
class VoicePlayer with ChangeNotifier {
  factory VoicePlayer({@required onError}) {
    return _cache ??= VoicePlayer._internal(onError: onError);
  }

  VoicePlayer._internal({@required onError}) {
    InAppLogger.debug('VoicePlayer._internal()');
    _fixedPlayer = AudioPlayer();
    AudioCache(fixedPlayer: _fixedPlayer);
    isPlaying = false;
    _speed = 1.0;
    locale = _voiceAccentMP3AssetsName[VoiceAccent.americanEnglish];
    _fixedPlayer.onPlayerStateChanged.listen(_onStateChanged);
    _fixedPlayer.onPlayerError.listen(onError);
  }

  /// singleton
  static VoicePlayer _cache;

  /// voice pronunciations
  AudioPlayer _fixedPlayer;
  AudioCache _player;

  /// on error callback
  Function onError;

  /// 再生中かどうか?
  bool isPlaying;

  /// current playing speed
  double _speed;

  /// current pronunciation
  String locale;

  /// play queue(TODO)
  List<String> queue;

  @override
  void dispose() {
    print('dispose');
    _player.fixedPlayer.dispose();
    _cache.dispose();
    super.dispose();
  }

  void _onStateChanged(AudioPlayerState state) {
    if (state == AudioPlayerState.COMPLETED) {
      isPlaying = false;
    }
    print(state);
    notifyListeners();
  }

  Future<void> playMessages({@required List<Message> messages}) async {
    isPlaying = true;
    notifyListeners();
    await Future.forEach(messages, (message) async {
      await _player.load(message.assets.voice[locale]);
      final d = await _player.fixedPlayer.getDuration();
      await _player.play(message.assets.voice[locale]);
      print(d);
      await Future.delayed(Duration(milliseconds: d + 500));
    });
    isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await _player.fixedPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  void setSpeed(double speed) {
    assert([0.5, 0.75, 1, 1.25, 1.5].contains(speed));
    _player.fixedPlayer.setPlaybackRate(playbackRate: speed);
    _speed = speed;
    notifyListeners();
  }

  void setLocale(VoiceAccent voiceAccent) {
    assert(voiceAccent != VoiceAccent.japanese);
    locale = _voiceAccentMP3AssetsName[voiceAccent];
    notifyListeners();
  }
}
