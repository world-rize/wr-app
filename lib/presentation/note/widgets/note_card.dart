// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

class NoteCard extends StatelessWidget {
  NoteCard({
    @required this.note,
  });

  Note note;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.bodyText1;
    final subTitleStyle = Theme.of(context).primaryTextTheme.bodyText2;

    return ShadowedContainer(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
        ),
      ),
    );
  }
}
