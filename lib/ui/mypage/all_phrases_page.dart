// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

class AllPhrasesPage extends StatelessWidget {
  const AllPhrasesPage({this.filter});
  final bool Function(Phrase) filter;

  @override
  Widget build(BuildContext context) {
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
              .map((phrase) => phraseView(context, phrase))
              .toList(),
        ),
      ),
    );
  }
}