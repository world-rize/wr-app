// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/widgets/note_table.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
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
    final userNotifier = Provider.of<UserNotifier>(context);
    final notes = userNotifier.getUser().notes.values;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: notes.map((note) => _createNoteView(note)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
