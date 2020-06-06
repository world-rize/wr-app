// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/phrase_detail_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

class AllPhrasesPage extends StatelessWidget {
  const AllPhrasesPage({this.filter});
  final bool Function(Phrase) filter;

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final primaryColor = Theme.of(context).primaryColor;
    final masterData = Provider.of<MasterDataStore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('All Phrases'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: masterData
              .allPhrases()
              .where(filter)
              .map(
                (phrase) => PhraseCard(
                  phrase: phrase,
                  favorite: userStore.favorited(phrase),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AppBar(
                            title: Text(
                              I.of(context).phraseDetailTitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          body: PhrasesDetailPage(
                            phrase: phrase,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
