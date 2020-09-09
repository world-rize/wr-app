import 'package:flutter/cupertino.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/voice_accent.dart';

class FlashCardNotifier extends ChangeNotifier {
  FlashCardNotifier({
    @required this.note,
    @required VoiceAccent voiceAccent,
  }) {
    _nowCardIndex = 0;
    _autoScroll = false;
    _voiceAccent = _voiceAccent;
  }

  int _nowCardIndex;
  bool _autoScroll;
  VoiceAccent _voiceAccent;
  Note note;

  int get nowCardIndex {
    return _nowCardIndex;
  }

  // TODO: implement some control methods
  void next() {
    _nowCardIndex++;
    notifyListeners();
  }

  void toggleAutoScroll() {
    _autoScroll = !_autoScroll;
    notifyListeners();
  }

  bool get autoScroll => _autoScroll;

  VoiceAccent get voiceAccent => _voiceAccent;
}
