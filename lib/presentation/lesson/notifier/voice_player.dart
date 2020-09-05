// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/logger.dart';

/// phrase detail voice player
class VoicePlayer with ChangeNotifier {
  factory VoicePlayer({@required onError}) {
    return _cache ??= VoicePlayer._internal(onError: onError);
  }

  VoicePlayer._internal({@required onError}) {
    InAppLogger.debug('VoicePlayer._internal()');
    _fixedPlayer = AudioPlayer();
    _player = AudioCache(fixedPlayer: _fixedPlayer);
    isPlaying = false;
    speed = 1.0;
    locale = _locales[0];
    _fixedPlayer.onPlayerStateChanged.listen(onStateChanged);
    _fixedPlayer.onPlayerError.listen(onError);
  }

  /// singleton
  static VoicePlayer _cache;

  /// voice playing speeds
  static final List<double> _playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];

  /// voice pronunciations
  static final List<String> _locales = ['en-us', 'en-uk', 'en-au'];

  AudioPlayer _fixedPlayer;
  AudioCache _player;

  /// on error callback
  Function onError;

  /// voice is playing?
  // bool get isPlaying => _player.fixedPlayer.state == AudioPlayerState.PLAYING;
  bool isPlaying;

  /// current playing speed
  double speed;

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

  void onStateChanged(AudioPlayerState state) {
    if (state == AudioPlayerState.COMPLETED) {
      isPlaying = false;
    }
    print(state);
    notifyListeners();
  }

  /// play key phrase on entering the page
  Future<void> playKeyPhrase({@required Phrase phrase}) async {
    if (!phrase.assets.voice.containsKey(locale)) {
      throw Exception('locale $locale not found');
    }

    await _player.play(phrase.assets.voice[locale]);
    isPlaying = true;
    notifyListeners();
  }

  /// play a message
  Future<void> play(Message message) async {
    if (!message.assets.voice.containsKey(locale)) {
      throw Exception('locale $locale not found');
    }
    await _player.play(message.assets.voice[locale]);
    isPlaying = true;

    notifyListeners();
  }

  /// resume
  void resume() {
    _player.fixedPlayer.resume();
    isPlaying = true;
    notifyListeners();
  }

  /// stop
  void pause() {
    _player.fixedPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  /// play all messages
  Future<void> playAll({@required Phrase phrase}) async {
    // TODO: 途中でストップされるとバグる -> Stream?
    // 先に _player.load() 必要
    isPlaying = true;
    notifyListeners();
    await Future.forEach(phrase.example.value, (message) async {
      await _player.load(message.assets.voice[locale]);
      final d = await _player.fixedPlayer.getDuration();
      await _player.play(message.assets.voice[locale]);
      print(d);
      await Future.delayed(Duration(milliseconds: d + 500));
    });
    isPlaying = false;
    notifyListeners();
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
