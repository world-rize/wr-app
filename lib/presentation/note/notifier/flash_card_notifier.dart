import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/voice_accent.dart';

class FlashCardNotifier extends ChangeNotifier {
  int _nowCardIndex;
  bool _autoScroll;
  VoiceAccent _voiceAccent;

  int get nowCardIndex {
    return _nowCardIndex;
  }

  bool get autoScroll => _autoScroll;

  VoiceAccent get voiceAccent => _voiceAccent;
}
