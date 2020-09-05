// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TTSNotifier with ChangeNotifier {
  factory TTSNotifier({@required onError}) {
    return _cache ??= TTSNotifier._internal(onError: onError);
  }

  TTSNotifier._internal({@required onError}) {
    _flutterTts = FlutterTts();
  }

  /// singleton
  static TTSNotifier _cache;

  FlutterTts _flutterTts;
  String _language;
  static double _volume = 0.5;
  static double _pitch = 1.0;
  static double _rate = 0.5;
  String _newVoiceText;

  TtsState _ttsState = TtsState.stopped;

  get isPlaying => _ttsState == TtsState.playing;

  get isStopped => _ttsState == TtsState.stopped;

  get isPaused => _ttsState == TtsState.paused;

  get isContinued => _ttsState == TtsState.continued;

  Future<void> play(String text) async {
    final completer = Completer<void>();
    await _flutterTts.speak(text);
    _flutterTts.setCompletionHandler(completer.complete);
    return completer.future;
  }

  Future<void> stop() async {
    var result = await _flutterTts.stop();
    if (result == 1) {
      _ttsState = TtsState.stopped;
    }
    notifyListeners();
  }
}
