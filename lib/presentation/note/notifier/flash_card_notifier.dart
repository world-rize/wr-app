import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/voice_accent.dart';

enum TtsState { playing, stopped }

const Map<VoiceAccent, String> _voiceAccentFlutterTtsMap = {
  VoiceAccent.japanese: 'jp-JP',
  VoiceAccent.americanEnglish: 'en-US',
  VoiceAccent.australiaEnglish: 'en-AU',
  VoiceAccent.britishEnglish: 'en-GB',
  VoiceAccent.indianEnglish: 'en-IN',
};

/// フラッシュカードの操作
class FlashCardNotifier extends ChangeNotifier {
  FlashCardNotifier({
    @required this.note,
  }) {
    note = note;
    originalNotePhrases = [
      ...note.phrases.values,
    ];
    notePhrases = [...originalNotePhrases];
    _nowPhraseIndex = 0;
    _autoScroll = true;
    _isShuffle = false;
    _voiceAccent = VoiceAccent.americanEnglish;
    _flutterTts = FlutterTts();
    _ttsState = TtsState.stopped;
  }

  Note note;

  /// 並び替えられる可能性があるので変更せずに持っておく
  List<NotePhrase> originalNotePhrases;
  List<NotePhrase> notePhrases;

  int _nowPhraseIndex;
  bool _autoScroll;
  bool _isShuffle;
  VoiceAccent _voiceAccent;
  FlutterTts _flutterTts;
  final double _volume = 0.5;
  final double _pitch = 1;
  double _rate = 0.5;
  TtsState _ttsState;

  PageController _pageController;

  VoiceAccent get voiceAccent => _voiceAccent;

  bool get autoScroll => _autoScroll;

  bool get isPlaying => _ttsState == TtsState.playing;

  bool get isStopped => _ttsState == TtsState.stopped;

  bool get isShuffle => _isShuffle;

  TtsState get ttsState => _ttsState;

  // get isPaused => _ttsState == TtsState.paused;

  // get isContinued => _ttsState == TtsState.continued;

  int get nowPhraseIndex => _nowPhraseIndex;

  set pageController(PageController pageController) {
    _pageController = pageController;
    _pageController.addListener(() {
      _nowPhraseIndex = _pageController.page.round();
      notifyListeners();
    });
  }

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

  void activateShuffling() {
    _isShuffle = true;
    if (isStopped) {
      print('shuffle!!!');
      notePhrases.shuffle();
    }
    notifyListeners();
  }

  void deactivateShuffling() {
    _isShuffle = false;
    notePhrases = [...originalNotePhrases];
    notifyListeners();
  }

  /// 音声を再生する
  /// completerを毎回セットする必要がある
  Future<void> play() async {
    _ttsState = TtsState.playing;
    notifyListeners();

    final nowPhrase = notePhrases[_nowPhraseIndex];

    // wait play word
    final completerWord = Completer<void>();
    await _flutterTts.speak(nowPhrase.word);
    _flutterTts.setCompletionHandler(completerWord.complete);
    await completerWord.future;

    // wait play translation
    // TODO: 言語に対応していないと再生できない
    await _flutterTts.speak(nowPhrase.translation);
    final completerTranslation = Completer<void>();
    _flutterTts.setCompletionHandler(completerTranslation.complete);
    await completerTranslation.future;

    while (_autoScroll) {
      _nowPhraseIndex = _nowPhraseIndex + 1;
      await _pageController.animateToPage(
        _nowPhraseIndex % notePhrases.length,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
      final nowPhrase = notePhrases[_nowPhraseIndex];

      final completerWord = Completer<void>();
      await _flutterTts.speak(nowPhrase.word);
      _flutterTts.setCompletionHandler(completerWord.complete);
      await completerWord.future;
      await _flutterTts.speak(nowPhrase.translation);
      final completerTranslation = Completer<void>();
      _flutterTts.setCompletionHandler(completerTranslation.complete);
      await completerTranslation.future;

      // player last
      if (_nowPhraseIndex == notePhrases.length) {
        _nowPhraseIndex = _nowPhraseIndex % notePhrases.length;
        break;
      }
    }
    _ttsState = TtsState.stopped;
    notifyListeners();
  }

  Future<void> stop() async {
    print('stopping in');
    _ttsState = TtsState.stopped;
    notifyListeners();
    final result = await _flutterTts.stop();
    final completer = Completer<void>();
    _flutterTts.setCompletionHandler(completer.complete);
    await completer.future;
    print('sapped in');
  }

  Future<void> getLanguages() async {
    (await _flutterTts.getLanguages).for_each(print);
  }
}
