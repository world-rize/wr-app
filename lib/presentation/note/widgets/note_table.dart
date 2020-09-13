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
import 'package:wr_app/util/logger.dart';

/// ノートのフレーズを表示するテーブル
class NoteTable extends StatefulWidget {
  NoteTable({
    @required this.note,
    @required this.onDeleted,
  });

  Note note;
  Function onDeleted;

  @override
  _NoteTableState createState() => _NoteTableState();
}

class _NoteTableState extends State<NoteTable> {
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

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
                    noteId: widget.note.id,
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

  void _showDeleteNoteConfirmDialog() {
    final un = Provider.of<UserNotifier>(context, listen: false);
    final nn = Provider.of<NoteNotifier>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('ノート"${widget.note.title}"を削除してもよろしいですか？'),
          actions: <Widget>[
            FlatButton(
              child: const Text('キャンセル'),
              key: const Key('cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('はい'),
              key: const Key('ok'),
              onPressed: () async {
                try {
                  setState(() {
                    _isLoading = true;
                  });
                  await un.deleteNote(noteId: widget.note.id);
                  nn.nowSelectedNoteId = null;

                  Navigator.pop(context);

                  widget.onDeleted();
                } on Exception catch (e) {
                  InAppLogger.error(e);
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

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
              noteId: widget.note.id,
              phraseId: phrase.id,
              phrase: phrase,
            );
            Navigator.pop(context);
          },
          onDelete: (phrase) {
            un.deletePhraseInNote(noteId: widget.note.id, phraseId: phrase.id);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
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
              Text(widget.note.title, style: h5),
              const Icon(Icons.keyboard_arrow_down),
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
              note: widget.note,
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

        ...widget.note.phrases
            .map((phrase) =>
                _createPhraseRow(context: context, un: un, phrase: phrase))
            .toList(),
      ],
    );

    final _deleteNoteButton = FlatButton(
      child: Row(
        children: [
          Text('- ノートを削除', style: h5.apply(color: Colors.redAccent)),
        ],
      ),
      onPressed: () {
        _showDeleteNoteConfirmDialog();
      },
    );

    return Column(
      children: [
        title,
        header,
        phrasesTable.padding(),
        if (!widget.note.isDefault && widget.note.id != 'achieved')
          Padding(
            padding: const EdgeInsets.all(8),
            child: _deleteNoteButton,
          ),
      ],
    );
  }
}
