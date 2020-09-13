// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/widgets/note_card.dart';
import 'package:wr_app/presentation/note/widgets/note_edit_dialog.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';
import 'package:wr_app/util/logger.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final nn = Provider.of<NoteNotifier>(context);
    final notes = un.getUser().notes.values;
    final h6 = Theme.of(context).textTheme.headline6;

    void _showErrorDialog(String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: const Text('ok'),
                key: const Key('ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    void _showAddNoteDialog() {
      showDialog(
        context: context,
        builder: (context) => NoteEditDialog(
          onSubmit: (title) async {
            try {
              setState(() {
                _isLoading = true;
              });
              Navigator.pop(context);
              await un.createNote(title: title);
            } on Exception catch (e) {
              InAppLogger.error(e);
              _showErrorDialog(e.toString());
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    final _createNoteButton = FlatButton(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text('+ ノートを作成', style: h6.apply(color: Colors.blueAccent)),
          ],
        ),
      ),
      onPressed: () {
        _showAddNoteDialog();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ノート一覧'),
      ),
      body: LoadingView(
        loading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createNoteButton,

              // achieved note
              NoteCard(
                note: un.getAchievedNote(),
              ),

              ...notes.map((note) => NoteCard(note: note)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
