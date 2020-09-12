// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/notifier/voice_player.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/phrase_detail_page_view.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/play_button.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/toast.dart';

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final phrase = section.phrases[index];
    final existNotes = userNotifier.existPhraseInNotes(phraseId: phrase.id);

    final _addNotesButton = IconButton(
      icon: Icon(existNotes ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () {
        userNotifier.addPhraseInNote(
          noteId: 'default',
          phrase: NotePhrase.fromPhrase(section.phrases[index]),
        );
      },
    );

    return ChangeNotifierProvider<VoicePlayer>.value(
      value: VoicePlayer(
        onError: NotifyToast.error,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            I.of(context).phraseDetailTitle,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [_addNotesButton],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (i) {
            setState(() => index = i);
          },
          children: section.phrases
              .map((phrase) => PhraseDetailPageView(phrase: phrase))
              .toList(),
        ),
        // controller
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            child: PhrasePlayButton(
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
