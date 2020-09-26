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
  });

  Note note;

  @override
  Widget build(BuildContext context) {
    final nn = Provider.of<NoteNotifier>(context, listen: false);
    final titleStyle =
        Theme.of(context).primaryTextTheme.bodyText1.apply(color: Colors.black);
    final subTitleStyle =
        Theme.of(context).primaryTextTheme.bodyText2.apply(color: Colors.black);
    final achieved = note.isAchievedNote;

    return InkWell(
      onTap: () {
        // switch note
        nn.nowSelectedNoteId = note.id;
        Navigator.of(context).pop();
      },
      child: ShadowedContainer(
        color: achieved ? Colors.grey[200] : Colors.white,
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
