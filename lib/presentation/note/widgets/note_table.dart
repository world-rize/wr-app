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
import 'package:wr_app/util/extensions.dart';

/// ノートのフレーズを表示するテーブル
class NoteTable extends StatelessWidget {
  NoteTable({
    @required this.note,
  });

  Note note;

  TableRow _createPhraseRow({
    @required BuildContext context,
    @required UserNotifier un,
    @required NotePhrase phrase,
  }) {
    return TableRow(
      children: [
        TableCell(
          child: Center(
            child: IconButton(
              icon: Icon(
                phrase.achieved
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.green,
              ),
              onPressed: () {
                un.achievePhraseInNote(
                    noteId: note.id,
                    phraseId: phrase.id,
                    achieve: !phrase.achieved);
              },
            ),
          ).padding(),
        ),
        TableCell(
          child: InkWell(
            onTap: () {
              // _showPhraseEditDialog(phrase);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(Provider.of<NoteNotifier>(context).canSeeJapanese
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
                child: Text(Provider.of<NoteNotifier>(context).canSeeEnglish
                    ? phrase.word
                    : ''),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final nn = Provider.of<NoteNotifier>(context, listen: false);
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
          child: Row(
            children: [
              Text(note.title, style: h5),
              Icon(Icons.keyboard_arrow_down),
            ],
          ).padding(),
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

    print(note.phrases.map((p) => p.id).join(', '));

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

    final _tableHeader = TableRow(
      children: [
        const TableCell(
          // empty widget
          child: SizedBox.shrink(),
        ),
        TableCell(
          child: GestureDetector(
            onTap: () {
              nn.toggleSeeJapanese();
            },
            child: Container(
              color: nn.canSeeJapanese ? Colors.white : Colors.green,
              child: const Center(
                child: Text('Japanese'),
              ).padding(),
            ),
          ),
        ),
        TableCell(
          child: GestureDetector(
            onTap: () {
              nn.toggleSeeEnglish();
            },
            child: Container(
              color: nn.canSeeEnglish ? Colors.white : Colors.green,
              child: const Center(
                child: Text('English'),
              ).padding(),
            ),
          ),
        ),
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
          _tableHeader,

          ...note.phrases
              .map((phrase) =>
                  _createPhraseRow(context: context, un: un, phrase: phrase))
              .toList(),
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
