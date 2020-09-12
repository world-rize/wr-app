// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/widgets/note_table.dart';
import 'package:wr_app/presentation/note/widgets/phrase_edit_dialog.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatelessWidget {
  void _showAddPhraseDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => PhraseEditDialog(
        onSubmit: (phrase) {
          Provider.of<UserNotifier>(context, listen: false)
              .addPhraseInNote(noteId: note.id, phrase: phrase);
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _createNoteView(BuildContext context, Note note) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          if (note == null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('ノートがまだありません',
                  style: theme.textTheme.headline5.apply(color: Colors.grey)),
            )
          else
            NoteTable(note: note),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // default note
    final userNotifier = Provider.of<UserNotifier>(context);
    final noteNotifier = Provider.of<NoteNotifier>(context);

    // FIXME: noteNotifierのデフォルトのnote idを設定できない
    // TODO: NoteNotifierに直接Noteをもたせてもいいかもしれない
    final note = noteNotifier.nowSelectedNoteId == null
        ? userNotifier.getUser()?.notes['default']
        : userNotifier
            .getUser()
            .notes
            .values
            .firstWhere((note) => note.id == noteNotifier.nowSelectedNoteId);
    // noteNotifier.nowSelectedNoteId = note.id;

    return Scaffold(body: _createNoteView(context, note));
  }
}
