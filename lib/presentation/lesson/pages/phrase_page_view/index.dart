// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/voice_accent.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/phrase_page_view/widgets/phrase_detail_page.dart';
import 'package:wr_app/presentation/lesson/pages/phrase_page_view/widgets/setting_dialog.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

class PhrasePageView extends StatelessWidget {
  const PhrasePageView({@required this.section, @required this.index});

  /// カテゴリーの中のどのセクションか
  final Section section;

  /// sectionの何番目のPhraseか
  final int index;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: VoicePlayer(
        onError: NotifyToast.error,
      ),
      child: ChangeNotifierProvider.value(
        value: PhrasePageViewModel(section: section, index: index),
        child: _PhrasePageView(),
      ),
    );
  }
}

class PhrasePageViewModel extends ChangeNotifier {
  PhrasePageViewModel({
    @required this.section,
    @required index,
  })  : pageController = PageController(initialPage: index),
        _index = index;

  User _user;
  final Section section;
  final PageController pageController;
  int _index;

  // current phrase
  Phrase get phrase => section.phrases[_index];

  // exist phrase?
  bool get existNodes => _user.existPhraseInNotes(phraseId: phrase.id);

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  Future fetchUser() async {
    final us = GetIt.I<UserService>();
    _user = await us.readUser();
  }
}

class _PhrasePageView extends StatelessWidget {
  void _showPhraseDetailSettingsDialog(BuildContext context) {
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context, scrollController) => Material(
        child: SafeArea(
          top: false,
          child: PhraseDetailSettingsDialog(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ln = context.watch<LessonNotifier>();
    final state = context.watch<PhrasePageViewModel>();
    final vp = context.watch<VoicePlayer>();

    final _menuButton = IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => _showPhraseDetailSettingsDialog(context),
    );

    final _phrasePlayButton = FloatingActionButton(
      isExtended: true,
      backgroundColor: Colors.blue,
      child: Icon(
        vp.isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () async {
        if (vp.isPlaying) {
          await vp.stop();
        } else {
          await vp.playMessages(messages: state.phrase.example.value);
        }
      },
    );

    final _toggleVisibilityButtons = Row(
      children: [
        // japanese toggle button
        RaisedButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/icon/hiragana_a.png',
              scale: 2.5,
            ),
          ),
          color: ln.showJapanese ? Colors.white : Colors.grey,
          shape: CircleBorder(),
          onPressed: () {
            ln.toggleJapanese();
          },
        ),
        // english toggle button
        RaisedButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/icon/alphabet_a.png',
              scale: 2.5,
            ),
          ),
          color: ln.showEnglish ? Colors.white : Colors.grey,
          shape: const CircleBorder(),
          onPressed: () {
            ln.toggleEnglish();
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          I.of(context).phraseDetailTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          _menuButton,
        ],
      ),
      body: PageView(
        controller: state.pageController,
        onPageChanged: (i) {
          state.index = i;
        },
        children: state.section.phrases
            .map(
              // TODO: Floatingボタンの下に説明が書かれているのでpadding
              //  画面のサイズによるのでPaddingやめたい
              // deviceによってむらがある
              (phrase) => PhraseDetailPage(phrase: phrase),
            )
            .toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: _phrasePlayButton,
                    ),
                    const Spacer(),
                    _toggleVisibilityButtons,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const Map<VoiceAccent, String> _voiceAccentMP3AssetsName = {
  VoiceAccent.americanEnglish: 'en-us',
  VoiceAccent.australiaEnglish: 'en-uk',
  VoiceAccent.britishEnglish: 'en-au',
  VoiceAccent.indianEnglish: 'en-in',
};

enum Visibility {
  all,
  // 英語
  englishOnly,
  // 日本語
  japaneseOnly,
}

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
    _speed = 1.0;
    locale = VoiceAccent.americanEnglish;
    _fixedPlayer.onPlayerStateChanged.listen(_onStateChanged);
    _fixedPlayer.onPlayerError.listen(onError);
  }

  /// singleton
  static VoicePlayer _cache;

  /// voice pronunciations
  AudioPlayer _fixedPlayer;
  AudioCache _player;

  /// on error callback
  Function onError;

  /// 再生中かどうか?
  bool isPlaying;

  /// current playing speed
  double _speed;

  double get speed => _speed;

  /// current pronunciation
  VoiceAccent locale;

  @override
  void dispose() {
    stop();
    _player.fixedPlayer.dispose();
    _cache.dispose();
    super.dispose();
  }

  void _onStateChanged(AudioPlayerState state) {
    // if (state == AudioPlayerState.COMPLETED) {
    //   isPlaying = false;
    // }
    print(state);
    notifyListeners();
  }

  Future<void> playMessages({@required List<Message> messages}) async {
    // _fixedPlayer.
    isPlaying = true;
    notifyListeners();
    // TODO: queue でやらないと割り込みに対応できない
    await Future.forEach(messages, (Message message) async {
      final l = _voiceAccentMP3AssetsName[locale];

      await _player.load(message.assets.voice[l]);
      await _player.play(message.assets.voice[l]);
      final c = Completer();
      final sub = _fixedPlayer.onPlayerCompletion.listen((event) {
        c.complete();
      });
      await c.future;
      // // remove listener
      await sub.cancel();
    }).catchError(() {
      print('canceled');
    });
    isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await _player.fixedPlayer.stop();
    final c = Completer();
    final sub = _fixedPlayer.onPlayerCompletion.listen((event) {
      c.complete();
    });
    isPlaying = false;
    await sub.cancel();
    notifyListeners();
  }

  void setSpeed(double speed) {
    assert([0.5, 0.75, 1, 1.25, 1.5].contains(speed));
    _player.fixedPlayer.setPlaybackRate(playbackRate: speed);
    _speed = speed;
    notifyListeners();
  }

  void setLocale(VoiceAccent voiceAccent) {
    assert(voiceAccent != VoiceAccent.japanese);
    locale = voiceAccent;
    notifyListeners();
  }
}
