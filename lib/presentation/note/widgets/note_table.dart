// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/language.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/pages/flash_card_page.dart';
import 'package:wr_app/presentation/note/pages/note_list_page.dart';
import 'package:wr_app/presentation/note/widgets/phrase_edit_dialog.dart';

/// ノートのフレーズを表示するテーブル
class NoteTable extends StatelessWidget {
  NoteTable({
    @required this.note,
  });

  Note note;

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
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
        const Spacer(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8).add(EdgeInsets.only(right: 8)),
          child: playButton,
        )
      ],
    );

    // TODO: 順番保持 -> array
    // 見かけは30こ
    final phrases = note.phrases..sort((a, b) => a.id.compareTo(b.id));

    void _showPhraseEditDialog(NotePhrase phrase, Language language) {
      final un = Provider.of<UserNotifier>(context, listen: false);
      showMaterialModalBottomSheet(
        context: context,
        builder: (BuildContext context, scrollController) => Container(
          child: PhraseEditDialog(
            phrase: phrase,
            language: language,
            onSubmit: (phrase) {
              un.updatePhraseInNote(
                noteId: note.id,
                phraseId: phrase.id,
                phrase: phrase,
              );
              Navigator.pop(context);
            },
            onDelete: (phrase) {
              un.deletePhraseInNote(noteId: note.id, phraseId: phrase.id);
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }

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
          TableRow(
            children: [
              const TableCell(
                // empty widget
                child: SizedBox.shrink(),
              ),
              TableCell(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<NoteNotifier>(context).toggleSeeJapanese();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('Japanese'),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<NoteNotifier>(context).toggleSeeEnglish();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('English'),
                    ),
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
                          un.achievePhraseInNote(
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
                      // _showPhraseEditDialog(phrase);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                            Provider.of<NoteNotifier>(context).canSeeJapanese
                                ? phrase.translation
                                : ''),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: InkWell(
                    onTap: () {
                      // _showPhraseEditDialog(phrase);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                            Provider.of<NoteNotifier>(context).canSeeEnglish
                                ? phrase.word
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
