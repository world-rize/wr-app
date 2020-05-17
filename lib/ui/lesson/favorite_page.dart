// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final masterData = Provider.of<MasterDataStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Phrases'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: masterData
              .allPhrases()
              .where((phrase) =>
                  userStore.user.favorites.containsKey(phrase.id) &&
                  userStore.user.favorites[phrase.id])
              .map((phrase) => phraseView(context, phrase, onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            LessonPhrasesDetailPage(phrase: phrase)));
                  }))
              .toList(),
        ),
      ),
    );
  }
}
