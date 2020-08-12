// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';

/// phrase detail voice player
class VoicePlayer with ChangeNotifier {
  VoicePlayer({
    @required this.phrase,
    @required this.onError,
  }) {
    speed = 1.0;
    locale = _locales[0];

    print(phrase.id);

    _fixedPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print(state);
      notifyListeners();
    });

    // playKeyPhrase();
  }

  static final AudioPlayer _fixedPlayer = AudioPlayer();
  static final AudioCache _player = AudioCache(fixedPlayer: _fixedPlayer);

  /// voice playing speeds
  static final List<double> _playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];

  /// voice pronunciations
  static final List<String> _locales = ['en-us', 'en-uk', 'en-au'];

  @override
  void dispose() {
    _player.fixedPlayer.stop();
    _player.fixedPlayer.dispose();
    super.dispose();
  }

  /// target phrase
  final Phrase phrase;

  /// on error callback
  final Function onError;

  /// voice is playing?
  bool get isPlaying => _player.fixedPlayer.state == AudioPlayerState.PLAYING;

  /// current playing speed
  double speed;

  /// current pronunciation
  String locale;

  /// return voice asset path
  String get voicePath {
    return phrase.assets.voice[locale] ?? 'voice_sample.mp3';
  }

  /// play key phrase on entering the page
  void playKeyPhrase() {
    _player.play(phrase.assets.voice[locale]).catchError(onError);
    notifyListeners();
  }

  Future<void> play(Message message) async {
    await _player.play(message.assets.voice[locale]);
  }

  Future<void> playAll() async {
    // dirty
    await Future.forEach(phrase.example.value, (message) async {
      await _player.load(message.assets.voice[locale]);
      final d = await _player.fixedPlayer.getDuration();
      await _player.play(message.assets.voice[locale]);
      await Future.delayed(Duration(milliseconds: d + 500));
    });
  }

  Future<void> pause() async {
    await _player.fixedPlayer.pause();
  }

  Future<void> toggle() async {
    await (!isPlaying ? playAll() : pause());
  }

  void toggleSpeed() {
    final _index = _playbackSpeeds.indexOf(speed);
    final _next = _playbackSpeeds[(_index + 1) % _playbackSpeeds.length];
    _player.fixedPlayer.setPlaybackRate(playbackRate: _next);
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
