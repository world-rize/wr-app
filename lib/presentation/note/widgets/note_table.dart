// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';

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

  @override
  void initState() {
    super.initState();
    _mode = NoteMode.both;
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);

    final header = Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              RaisedButton.icon(
                onPressed: () {
                  // toggle mode
                  setState(() {
                    _mode = NoteMode.values[(_mode.index + 1) % 3];
                  });
                },
                color: Colors.transparent,
                icon: const Icon(
                  AntDesign.retweet,
                  size: 40,
                ),
                label: Text(
                  _mode.name,
                  style: const TextStyle(fontSize: 24),
                ),
                elevation: 2,
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8).add(EdgeInsets.only(right: 8)),
          child: FlatButton(
            color: Colors.orange,
            child: Text(
              'Play',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        )
      ],
    );

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

          ...widget.note.phrases.values.map((phrase) {
            final favorited =
                userNotifier.existPhraseInFavoriteList(phraseId: phrase.id);

            return TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          favorited ? Icons.favorite : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          userNotifier.favoritePhrase(
                              phraseId: phrase.id, favorite: !favorited);
                        },
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: 編集できるように
                      print('edit jp');
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
                  child: GestureDetector(
                    onTap: () {
                      // TODO: 編集できるように
                      print('edit en');
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
        header,
        Padding(
          padding: const EdgeInsets.all(8),
          child: phrasesTable,
        ),
      ],
    );
  }
}
