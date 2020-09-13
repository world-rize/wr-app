// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/lesson/notifier/voice_player.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_card.dart';
import 'package:wr_app/util/toast.dart';

class AnythingSearchPage extends StatefulWidget {
  @override
  _AnythingSearchPageState createState() => _AnythingSearchPageState();
}

class _AnythingSearchPageState extends State<AnythingSearchPage> {
  String _word;
  List<Phrase> _phrases;

  Future<Iterable<Phrase>> _searchPhrases(String word) async {
    final r = RegExp(word, caseSensitive: false);
    final future = Future.microtask(() => _phrases.where((phrase) {
          if (_word.isNotEmpty) {
            return r.hasMatch(phrase.title['en']);
          } else {
            return false;
          }
        }).take(50));

    return future;
  }

  @override
  void initState() {
    super.initState();
    _word = '';
    _phrases = Provider.of<LessonNotifier>(context, listen: false).phrases;
  }

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context, listen: false);

    final _wordField = TextFormField(
      onChanged: (word) {
        setState(() => _word = word);
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: '単語など',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('検索'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _wordField,
            ),
            FutureBuilder<Iterable<Phrase>>(
                future: _searchPhrases(_word),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    // loading
                    return Text('loading');
                  } else {
                    return Column(
                      children: snapshot.data
                          .map(
                            (phrase) => PhraseCard(
                              phrase: phrase,
                              favorite: false,
                              onTap: () {
                                // TODO: voice player SectionPageの中に
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider<
                                        VoicePlayer>.value(
                                      value: VoicePlayer(
                                        onError: NotifyToast.error,
                                      ),
                                      builder: (_, __) => SectionPage(
                                        section: Section.fromPhrase(phrase),
                                        index: 0,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onFavorite: () {
                                un.favoritePhrase(
                                    phraseId: phrase.id,
                                    favorite: un.existPhraseInFavoriteList(
                                        phraseId: phrase.id));
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
