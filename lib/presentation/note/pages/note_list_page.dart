// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/index.dart';
import 'package:wr_app/presentation/note/widgets/note_card.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final notes = userNotifier.getUser().notes.values;
    final h6 = Theme.of(context).textTheme.headline6;

    void _showAddNoteDialog() {
      //TODO
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ノート一覧'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlatButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('+ ノートを作成', style: h6.apply(color: Colors.blueAccent)),
                  ],
                ),
              ),
              onPressed: () {
                _showAddNoteDialog();
              },
            ),
            ...notes
                .map((note) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // currentNoteにしてpop
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotePage(
                                note: note,
                              ),
                            ),
                          );
                        },
                        child: NoteCard(note: note),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
