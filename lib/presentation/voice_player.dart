// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
  factory VoicePlayer() {
    return _cache ??= VoicePlayer._internal();
  }

  VoicePlayer._internal() {
    InAppLogger.debug('VoicePlayer._internal()');
    isPlaying = false;
    _speed = 1.0;
    player = AssetsAudioPlayer();
    player.playlistFinished.listen((finished) {
      print('done? isPlaying: ${player.isPlaying.value}');
      if (finished) {
        InAppLogger.debug('done play');
      }
    });
    player.onErrorDo = (error) async {
      print(error.error);
    };
    locale = VoiceAccent.americanEnglish;
  }

  /// singleton
  static VoicePlayer _cache;

  /// 再生中かどうか?
  bool isPlaying;

  /// current playing speed
  double _speed;

  double get speed => _speed;

  AssetsAudioPlayer player;

  /// current pronunciation
  VoiceAccent locale;

  Future<void> playMessages({@required List<Message> messages}) async {
    isPlaying = true;
    notifyListeners();

    final paths = messages.map((m) {
      final l = _voiceAccentMP3AssetsName[locale];
      return Audio("assets/" + m.assets.voice[l]);
    }).toList();
    print('len ${paths.length}');
    await player.open(
      Playlist(audios: paths),
      autoStart: false,
      loopMode: LoopMode.single,
    );
    await Future.forEach(paths, (path) async {
      await player.play();
      final c = Completer();
      final a = player.playlistFinished.listen((finished) async {
        print('finished $finished');
        if (finished) {
          c.complete();
        }
      });
      await c.future;
      await player.next();
    });
    isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await player.stop();
    isPlaying = false;
    notifyListeners();
  }

  void setSpeed(double speed) {
    assert([0.5, 0.75, 1, 1.25, 1.5].contains(speed));
    player.setPlaySpeed(speed);
    _speed = speed;
    notifyListeners();
  }

  void setLocale(VoiceAccent voiceAccent) {
    assert(voiceAccent != VoiceAccent.japanese);
    locale = voiceAccent;
    notifyListeners();
  }
}
