// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';

class PhraseListTable extends StatelessWidget {
  PhraseListTable({@required this.phraseList});

  Note phraseList;

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);

    final header = Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              FlatButton.icon(
                onPressed: () {
                  print(userNotifier.getUser().notes.keys.toList());
                },
                color: Colors.transparent,
                icon: Icon(
                  Icons.folder_open,
                  size: 40,
                ),
                label: Text(
                  phraseList.title,
                  style: TextStyle(fontSize: 24),
                ),
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
                    child: Text('日本語'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text('英語'),
                  ),
                ),
              ),
            ],
          ),

          ...phraseList.phrases.values.map((phrase) {
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
                      print('edit jp');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(phrase.word),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: GestureDetector(
                    onTap: () {
                      print('edit en');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(phrase.translation),
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
