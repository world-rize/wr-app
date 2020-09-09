// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/pages/flash_card_page.dart';
import 'package:wr_app/presentation/note/pages/note_list_page.dart';
import 'package:wr_app/presentation/note/widgets/phrase_edit_dialog.dart';

enum NoteMode {
  wordOnly,
  both,
  translationOnly,
}

extension NoteModeMap on NoteMode {
  String get name => ['英語', '両方', '日本語'][index];
}

/// ノートのフレーズを表示するテーブル
class NoteTable extends StatefulWidget {
  NoteTable({
    @required this.note,
  });

  Note note;

  @override
  _NoteTableState createState() => _NoteTableState(note: note);
}

class _NoteTableState extends State<NoteTable> {
  _NoteTableState({
    @required this.note,
  });

  Note note;
  NoteMode _mode;

  void _showPhraseEditDialog(NotePhrase phrase) {
    showDialog(
      context: context,
      builder: (context) => PhraseEditDialog(
        phrase: phrase,
        onSubmit: (phrase) {
          final userNotifier = Provider.of<UserNotifier>(context, listen: false)
            ..updatePhraseInNote(
                noteId: note.id, phraseId: phrase.id, phrase: phrase);
          Navigator.pop(context);
        },
        onDelete: (phrase) {
          final userNotifier = Provider.of<UserNotifier>(context, listen: false)
            ..deletePhraseInNote(noteId: note.id, phraseId: phrase.id);
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mode = NoteMode.both;
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final h5 = Theme.of(context).textTheme.headline5;

    // ノート名
    final title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteListPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(note.title, style: h5),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );

    // 上部ボタン
    final bg = Theme.of(context).backgroundColor;
    final switchHideButton = RaisedButton.icon(
      onPressed: () {
        // toggle mode
        setState(() {
          _mode = NoteMode.values[(_mode.index + 1) % 3];
        });
      },
      color: bg,
      icon: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          FontAwesome.language,
          size: 20,
        ),
      ),
      label: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          _mode.name,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      elevation: 5,
    );

    final playButton = FlatButton(
      color: Colors.orange,
      child: const Text(
        'Play',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FlashCardPage(
              note: note,
            ),
          ),
        );
      },
    );

    final header = Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: switchHideButton,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8).add(EdgeInsets.only(right: 8)),
          child: playButton,
        )
      ],
    );

    // TODO: 順番保持 -> array
    final phrases = widget.note.phrases.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    final phrasesTable = Table(
        border: TableBorder.all(
          color: Colors.grey,
          width: 0.5,
        ),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
        },
        children: [
          // header
          const TableRow(
            children: [
              TableCell(
                // empty widget
                child: SizedBox.shrink(),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text('英語'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text('日本語'),
                  ),
                ),
              ),
            ],
          ),

          ...phrases.map((phrase) {
            return TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          phrase.achieved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          userNotifier.achievePhraseInNote(
                              noteId: note.id,
                              phraseId: phrase.id,
                              achieve: !phrase.achieved);
                        },
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: InkWell(
                    onTap: () {
                      _showPhraseEditDialog(phrase);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(_mode != NoteMode.translationOnly
                            ? phrase.word
                            : ''),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: InkWell(
                    onTap: () {
                      _showPhraseEditDialog(phrase);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(_mode != NoteMode.wordOnly
                            ? phrase.translation
                            : ''),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ]);

    return Column(
      children: [
        title,
        header,
        Padding(
          padding: const EdgeInsets.all(8),
          child: phrasesTable,
        ),
      ],
    );
  }
}
