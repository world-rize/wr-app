// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/model/message.dart';
import 'package:wr_app/model/phrase.dart';

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

  // State Options
  static final List<double> _playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];
  static final List<String> _locales = ['en-us', 'en-uk', 'en-au'];

  final Phrase phrase;
  final Function onError;

  bool isPlaying;
  double speed;
  String locale;

  // Player
  AudioPlayer _player;
  AudioCache _cache;

  String get voicePath {
    return phrase.assets.voice[locale] ?? 'voice_sample.mp3';
  }

  void playKeyPhrase() {}

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
