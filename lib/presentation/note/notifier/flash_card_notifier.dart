import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/voice_accent.dart';

enum TtsState { playing, stopped }

/// フラッシュカードの操作
class FlashCardNotifier extends ChangeNotifier {
  FlashCardNotifier({
    @required this.noteId,
    @required this.notePhrases,
  }) {
    print(notePhrases.map((e) => '${e.japanese}').join(','));

    originalNotePhrases = [...notePhrases];

    _nowPhraseIndex = 0;
    _autoScroll = true;
    _isShuffle = false;
    _showJapanese = true;
    _voiceAccent = VoiceAccent.americanEnglish;
    _flutterTts = FlutterTts();
    _ttsState = TtsState.stopped;
  }

  /// 元の並び
  List<NotePhrase> originalNotePhrases;

  /// フラッシュカードに表示するフレーズ
  List<NotePhrase> notePhrases;

  /// ノートID
  String noteId;

  /// 現在のindex
  int _nowPhraseIndex;

  /// 自動送りするか
  bool _autoScroll;

  /// 日本語を表示するか
  bool _showJapanese;

  /// シャッフルするか
  bool _isShuffle;

  /// アクセント
  VoiceAccent _voiceAccent;
  FlutterTts _flutterTts;

  /// 音量
  final double _volume = 0.5;

  ///
  final double _pitch = 1;

  /// 速度 0~1
  double _rate = 0.5;

  TtsState _ttsState;

  PageController _pageController;

  VoiceAccent get voiceAccent => _voiceAccent;

  bool get autoScroll => _autoScroll;

  bool get isPlaying => _ttsState == TtsState.playing;

  bool get isStopped => _ttsState == TtsState.stopped;

  bool get isShuffle => _isShuffle;

  bool get showJapanese => _showJapanese;

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

  void flipCard() {
    _showJapanese = !_showJapanese;
    notifyListeners();
  }

  double get playSpeed => _rate * 2;

  /// しゃべる倍率をわたす
  void setPlaySpeed(double speed) {
    // to 0 - 1
    print(speed);
    _rate = 0.5 * speed;
    _flutterTts.setSpeechRate(_rate);
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
    if (_showJapanese) {
      await _flutterTts
          .setLanguage(voiceAccentToTtsString(VoiceAccent.japanese));
      await _flutterTts.speak(nowPhrase.japanese);
    } else {
      await _flutterTts.setLanguage(voiceAccentToTtsString(voiceAccent));
      await _flutterTts.speak(nowPhrase.english);
    }
    final completer = Completer<void>();
    _flutterTts.setCompletionHandler(completer.complete);
    await completer.future;

    _ttsState = TtsState.stopped;
    notifyListeners();
  }

  /// 音声を再生する
  /// completerを毎回セットする必要がある
  Future<void> playAll() async {
    _ttsState = TtsState.playing;
    notifyListeners();

    // wait play translation
    // TODO: 言語に対応していないと再生できない
    do {
      final nowPhrase = notePhrases[_nowPhraseIndex];

      await _flutterTts
          .setLanguage(voiceAccentToTtsString(VoiceAccent.japanese));
      await _flutterTts.speak(nowPhrase.japanese);
      final completerTranslation = Completer<void>();
      _flutterTts.setCompletionHandler(completerTranslation.complete);
      await completerTranslation.future;

      await _flutterTts.setLanguage(voiceAccentToTtsString(voiceAccent));
      await _flutterTts.speak(nowPhrase.english);
      final completerWord = Completer<void>();
      _flutterTts.setCompletionHandler(completerWord.complete);
      await completerWord.future;

      _nowPhraseIndex = _nowPhraseIndex + 1;
      // player last
      if (_nowPhraseIndex == notePhrases.length) {
        _nowPhraseIndex = _nowPhraseIndex % notePhrases.length;
        break;
      }
      await _pageController.animateToPage(
        _nowPhraseIndex % notePhrases.length,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
    } while (_autoScroll);
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

  String voiceAccentToTtsString(VoiceAccent va) {
    return {
      VoiceAccent.japanese: 'ja-JP',
      VoiceAccent.americanEnglish: 'en-US',
      VoiceAccent.australiaEnglish: 'en-AU',
      VoiceAccent.britishEnglish: 'en-GB',
      VoiceAccent.indianEnglish: 'en-IN',
    }[va];
  }
}
