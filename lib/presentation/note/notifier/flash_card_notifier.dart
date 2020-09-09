import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/voice_accent.dart';

enum TtsState { playing, stopped, paused, continued }

const Map<VoiceAccent, String> _voiceAccentFlutterTtsMap = {
  VoiceAccent.japanese: 'jp-JP',
  VoiceAccent.americanEnglish: 'en-US',
  VoiceAccent.australiaEnglish: 'en-AU',
  VoiceAccent.britishEnglish: 'en-GB',
  VoiceAccent.indianEnglish: 'en-IN',
};

class FlashCardNotifier extends ChangeNotifier {
  FlashCardNotifier({
    @required this.note,
  }) {
    note = note;
    notePhrases = note.phrases.entries.map((entry) => entry.value).toList();
    _nowPhraseIndex = 0;
    _autoScroll = true;
    _voiceAccent = VoiceAccent.britishEnglish;
    _flutterTts = FlutterTts();
    _ttsState = TtsState.stopped;
  }

  Note note;

  /// 並び替えられる可能性がある
  List<NotePhrase> notePhrases;
  int _nowPhraseIndex;
  bool _autoScroll;
  VoiceAccent _voiceAccent;
  FlutterTts _flutterTts;
  final double _volume = 0.5;
  final double _pitch = 1;
  double _rate = 0.5;
  String _newVoiceText;
  TtsState _ttsState;
  PageController pageController;

  VoiceAccent get voiceAccent => _voiceAccent;

  bool get autoScroll => _autoScroll;

  get isPlaying => _ttsState == TtsState.playing;

  get isStopped => _ttsState == TtsState.stopped;

  // get isPaused => _ttsState == TtsState.paused;

  // get isContinued => _ttsState == TtsState.continued;

  int get nowPhraseIndex => _nowPhraseIndex;

  Future<void> setVoiceAccent(VoiceAccent voiceAccent) async {
    _voiceAccent = voiceAccent;
    await _flutterTts.setLanguage(_voiceAccentFlutterTtsMap[voiceAccent]);
    notifyListeners();
  }

  // TODO: implement some control methods
  void next() {
    _nowPhraseIndex++;
    notifyListeners();
  }

  void toggleAutoScroll() {
    _autoScroll = !_autoScroll;
    notifyListeners();
  }

  /// しゃべる倍率をわたす
  void setPlaySpeed(double speed) {
    _rate = 0.5 * speed;
    notifyListeners();
  }

  /// 音声を再生する
  Future<void> play() async {
    final completer = Completer<void>();
    final nowPhrase = notePhrases[_nowPhraseIndex];

    await _flutterTts.speak(nowPhrase.word);
    _flutterTts.setCompletionHandler(completer.complete);
    await completer.future;
    await _flutterTts.speak(nowPhrase.translation);
    _flutterTts.setCompletionHandler(completer.complete);
    await completer.future;
  }

  Future<void> stop() async {
    final result = await _flutterTts.stop();
    if (result == 1) {
      _ttsState = TtsState.stopped;
    }
    notifyListeners();
  }

  Future<void> nextPhrase() async {
    await pageController.animateToPage(
      _nowPhraseIndex + 1,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
    _nowPhraseIndex += 1 % notePhrases.length;
    notifyListeners();
  }

  Future<void> getLanguages() async {
    (await _flutterTts.getLanguages).for_each(print);
  }
}
