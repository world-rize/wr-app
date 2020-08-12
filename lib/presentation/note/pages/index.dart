// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/widgets/phrase_list_table.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userNotifier = Provider.of<UserNotifier>(context);
    final phraseList = userNotifier.getUser().notes['default'];

    return SingleChildScrollView(
      child: Column(
        children: [
          if (phraseList == null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('ノートがまだありません',
                  style: theme.textTheme.headline5.apply(color: Colors.grey)),
            )
          else
            PhraseListTable(phraseList: phraseList)
        ],
      ),
    );
  }
}
