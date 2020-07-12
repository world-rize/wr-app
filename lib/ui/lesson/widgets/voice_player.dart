// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';

/// phrase detail voice player
class VoicePlayer with ChangeNotifier {
  VoicePlayer({@required this.phrase, @required this.onError}) {
    isPlaying = false;
    speed = 1.0;
    locale = _locales[0];

    _player = AudioPlayer()
      ..onPlayerStateChanged.listen((AudioPlayerState state) {
        isPlaying = state == AudioPlayerState.PLAYING;
      });

    _cache = AudioCache(fixedPlayer: _player)
      ..load(voicePath).catchError(onError);
  }

  /// voice playing speeds
  static final List<double> _playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];

  /// voice pronunciations
  static final List<String> _locales = ['en-us', 'en-uk', 'en-au'];

  /// target phrase
  final Phrase phrase;

  /// on error callback
  final Function onError;

  /// voice is playing?
  bool isPlaying;

  /// current playing speed
  double speed;

  /// current pronunciation
  String locale;

  // Player
  AudioPlayer _player;
  AudioCache _cache;

  /// return voice asset path
  String get voicePath {
    return phrase.assets.voice[locale] ?? 'voice_sample.mp3';
  }

  /// play key phrase on entering the page
  void playKeyPhrase() {
    throw UnimplementedError();
  }

  /// play voices
  void play(Message message) {
    _cache.play(message.assets.voice[locale]).catchError(onError);
    notifyListeners();
  }

  void toggle() {
    if (!isPlaying) {
      _cache.play(voicePath).catchError(onError);
    } else {
      _cache.fixedPlayer.stop();
    }
    notifyListeners();
  }

  void toggleSpeed() {
    final _index = _playbackSpeeds.indexOf(speed);
    final _next = _playbackSpeeds[(_index + 1) % _playbackSpeeds.length];
    _cache.fixedPlayer.setPlaybackRate(playbackRate: _next);
    speed = _next;
    notifyListeners();
  }

  void toggleLocale() {
    final _index = _locales.indexOf(locale);
    final _next = _locales[(_index + 1) % _locales.length];
    locale = _next;
    notifyListeners();
  }
}
