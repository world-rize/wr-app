// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

class NoteCard extends StatelessWidget {
  NoteCard({
    @required this.note,
    this.achieved = false,
  });

  Note note;
  bool achieved;

  @override
  Widget build(BuildContext context) {
    final nn = Provider.of<NoteNotifier>(context, listen: false);
    final titleStyle = Theme.of(context).primaryTextTheme.bodyText1;
    final subTitleStyle = Theme.of(context).primaryTextTheme.bodyText2;

    return InkWell(
      onTap: () {
        // switch note
        nn.nowSelectedNoteId = note.id;
        Navigator.of(context).pop();
      },
      child: ShadowedContainer(
        color: achieved ? Colors.white : Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Text(note.title, style: titleStyle),
              ],
            ),
            Row(
              children: [
                Text('${note.phrases.length} フレーズ', style: subTitleStyle),
              ],
            )
          ],
        ).padding(16),
      ),
    ).padding();
  }
}
