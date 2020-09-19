// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/phrase_detail_page_view.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/setting_dialog.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/presentation/voice_player.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({@required this.section, @required this.index});

  final Section section;
  final int index;

  @override
  _SectionPageState createState() => _SectionPageState(
        section: section,
        index: index,
      );
}

class _SectionPageState extends State<SectionPage>
    with SingleTickerProviderStateMixin {
  _SectionPageState({
    @required this.section,
    @required this.index,
  });

  final Section section;
  PageController _pageController;
  int index;

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
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final vp = Provider.of<VoicePlayer>(context);
    final phrase = section.phrases[index];
    final existNotes = un.existPhraseInNotes(phraseId: phrase.id);

    final _menuButton = IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => _showPhraseDetailSettingsDialog(context),
    );

    final _phrasePlayButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: FloatingActionButton(
          isExtended: true,
          backgroundColor: Colors.blue,
          heroTag: 'play',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Play',
                style: Theme.of(context).primaryTextTheme.headline4,
              ),
              Icon(
                vp.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
          onPressed: () async {
            if (vp.isPlaying) {
              await vp.stop();
            } else {
              await vp.playMessages(messages: phrase.example.value);
            }
          },
        ),
      ),
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
        controller: _pageController,
        onPageChanged: (i) {
          setState(() => index = i);
        },
        children: section.phrases
            .map(
              // TODO: Floatingボタンの下に説明が書かれているのでpadding
              //  画面のサイズによるのでPaddingやめたい
              // deviceによってむらがある
              (phrase) => Padding(
                child: PhraseDetailPageView(phrase: phrase),
                padding: EdgeInsets.only(bottom: 100),
              ),
            )
            .toList(),
      ),
      // controller
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _phrasePlayButton,
    );
  }
}
