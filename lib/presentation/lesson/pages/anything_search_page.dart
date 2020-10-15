// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/pages/phrase_page_view/index.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_card.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/toast.dart';

class AnythingSearchPageModel extends ChangeNotifier {
  AnythingSeatchPageMode({List<Phrase> initialPhrases}) {
    _phrases = initialPhrases;
  }

  String _word;
  String get word => _word;
  List<Phrase> _phrases;

  set word(String value) {
    _word = value;
    notifyListeners();
  }

  // TODO: domain
  Future<Iterable<Phrase>> _searchPhrases(String word) async {
    final r = RegExp(word, caseSensitive: false);
    final future = Future.microtask(() => _phrases.where((phrase) {
          if (word.isNotEmpty) {
            return r.hasMatch(phrase.title['en']);
          } else {
            return false;
          }
        }).take(50));

    return future;
  }

  void _onTapPhrase(BuildContext context, Phrase phrase) {
    // TODO: voice player SectionPageの中に
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<VoicePlayer>.value(
          value: VoicePlayer(
            onError: NotifyToast.error,
          ),
          builder: (_, __) => PhrasePageView(
            section: Section.fromPhrase(phrase),
            index: 0,
          ),
        ),
      ),
    );
  }

  Future _onFavoritePhrase(BuildContext context, Phrase phrase) async {
    final un = context.read<UserNotifier>();

    await un.favoritePhrase(
        phraseId: phrase.id,
        favorite: un.existPhraseInFavoriteList(phraseId: phrase.id));
  }

  // result
  Widget searchResultList(BuildContext context) {
    final _loadingView = const Text('loading');

    return FutureBuilder<Iterable<Phrase>>(
      future: _searchPhrases(_word),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return _loadingView;
        }
        return Column(
          children: [
            if (snapshot.hasData && snapshot.data.isNotEmpty)
              Text('${snapshot.data.length} フレーズみつかりました').padding(),
            ...snapshot.data
                .map(
                  (phrase) => PhraseCard(
                    phrase: phrase,
                    favorite: false,
                    onTap: () => _onTapPhrase(context, phrase),
                    onFavorite: () => _onFavoritePhrase(context, phrase),
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }
}

class AnythingSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AnythingSearchPageModel(),
      child: _AnythingSearchPage(),
    );
  }
}

class _AnythingSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AnythingSearchPageModel>();

    final _wordField = TextFormField(
      onChanged: (word) {
        state.word = word;
      },
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: I.of(context).lessonSearchHintText,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).lessonSearchAppBarTitle),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: _wordField,
              ),
              state.searchResultList(context),
            ],
          ),
        ),
      ),
    );
  }
}
