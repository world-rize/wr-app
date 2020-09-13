// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/widgets/note_table.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatefulWidget {
//  void _showAddPhraseDialog(BuildContext context, Note note) {
//    showDialog(
//      context: context,
//      builder: (context) => PhraseEditDialog(
//        language: Language.america,
//        onSubmit: (phrase) {
//          Provider.of<UserNotifier>(context, listen: false)
//              .addPhraseInNote(noteId: note.id, phrase: phrase);
//          Navigator.pop(context);
//        },
//        onCancel: () {
//          Navigator.pop(context);
//        },
//      ),
//    );
//  }

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // default note
    final un = Provider.of<UserNotifier>(context);
    final nn = Provider.of<NoteNotifier>(context);
    final theme = Theme.of(context);

    // FIXME: noteNotifierのデフォルトのnote idを設定できない
    // TODO: NoteNotifierに直接Noteをもたせてもいいかもしれない
    final note = un.getNoteById(noteId: nn.nowSelectedNoteId);

    final _noteNotFoundView = Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          'ノートがありません',
          style: theme.textTheme.headline5.apply(color: Colors.grey),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            if (note == null)
              _noteNotFoundView
            else
              NoteTable(
                note: note,
                onDeleted: () {
                  _controller.animateTo(
                    0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 500),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
