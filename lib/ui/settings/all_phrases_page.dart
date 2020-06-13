// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/ui/lesson/section_list_page.dart';

class AllPhrasesPage extends StatelessWidget {
  const AllPhrasesPage({this.filter});
  final bool Function(Phrase) filter;

  @override
  Widget build(BuildContext context) {
    final masterData = Provider.of<MasterDataStore>(context);
    final allPhrases = masterData.allPhrases();

    return SectionListPage(
      section: Section(
        title: 'all',
        phrases: allPhrases,
      ),
    );
  }
}
