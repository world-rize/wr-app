// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase_list.dart';
import 'package:wr_app/presentation/note/widgets/note_header.dart';
import 'package:wr_app/presentation/note/widgets/phrase_list_table.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          NoteHeader(),
          PhraseListTable(
            phraseList: PhraseList.dummy('ノート1', isDefault: true),
          ),
        ],
      ),
    );
  }
}
