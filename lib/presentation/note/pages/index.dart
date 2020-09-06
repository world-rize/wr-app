// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/widgets/note_table.dart';
import 'package:wr_app/presentation/note/widgets/phrase_edit_dialog.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatefulWidget {
  NotePage({this.note});

  Note note;

  @override
  _NotePageState createState() => _NotePageState(note: note);
}

class _NotePageState extends State<NotePage> {
  _NotePageState({@required this.note});

  Note note;

  void _showAddPhraseDialog() {
    showDialog(
      context: context,
      builder: (context) => PhraseEditDialog(
        onSubmit: (phrase) {
          final userNotifier =
              Provider.of<UserNotifier>(context, listen: false);
          userNotifier.addPhraseInNote(noteId: note.id, phrase: phrase);
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _createNoteView(Note note) {
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
    note ??= userNotifier.getUser().notes['default'];

    return Scaffold(
      body: _createNoteView(note),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPhraseDialog();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
