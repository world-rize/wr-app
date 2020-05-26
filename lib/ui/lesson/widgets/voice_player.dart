// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:wr_app/model/message.dart';
import 'package:wr_app/model/phrase.dart';

class VoicePlayer {
  VoicePlayer({@required this.phrase, @required this.onError}) {
    isPlaying = false;
    speed = 1.0;
    locale = locales[0];

    _player = AudioPlayer()
      ..onPlayerStateChanged.listen((AudioPlayerState state) {
        isPlaying = state == AudioPlayerState.PLAYING;
      });

    _cache = AudioCache(fixedPlayer: _player)
      ..load(voicePath).catchError(onError);
  }

  // State Options
  static List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];
  static List<String> locales = ['en-us', 'en-uk', 'en-au'];

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
  }

  void toggle() {
    if (!isPlaying) {
      _cache.play(voicePath).catchError(onError);
    } else {
      _cache.fixedPlayer.stop();
    }
  }

  void toggleSpeed() {
    final _index = playbackSpeeds.indexOf(speed);
    final _next = playbackSpeeds[(_index + 1) % playbackSpeeds.length];
    _cache.fixedPlayer.setPlaybackRate(playbackRate: _next);
    speed = _next;
  }

  void toggleLocale() {
    final _index = locales.indexOf(locale);
    final _next = locales[(_index + 1) % locales.length];
    locale = _next;
  }
}
