// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/language.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/pages/achieved_phrase_list.dart';
import 'package:wr_app/presentation/note/pages/flash_card_page.dart';
import 'package:wr_app/presentation/note/pages/note_list_page.dart';
import 'package:wr_app/presentation/note/widgets/note_table_edit_phrase.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ノートのフレーズを表示するテーブル
class NoteTable extends StatefulWidget {
  NoteTable({
    required this.note,
    required this.onDeleted,
  });

  Note note;
  Function onDeleted;

  @override
  _NoteTableState createState() => _NoteTableState();
}

class _NoteTableState extends State<NoteTable> {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  void _showDeleteNoteConfirmDialog() {
    final nn = context.read<NoteNotifier>();

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
                  await nn.deleteNote(noteId: widget.note.id);
                  nn.nowSelectedNoteId = 'dafault';

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

  void _showAchievePhraseConfirmDialog({
    required Widget message,
    required Function onAchieve,
    required Function onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: message,
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              key: const Key('cancel'),
              onPressed: () {
                onCancel();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('Achieve!'),
              key: const Key('ok'),
              onPressed: () async {
                onAchieve();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nn = Provider.of<NoteNotifier>(context);
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
            builder: (_) => FlashCardPage(),
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
              color: nn.canSeeJapanese
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.green,
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
              color: nn.canSeeEnglish
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.green,
              child: const Center(
                child: Text('English'),
              ).padding(),
            ),
          ),
        ),
      ],
    );

    TableRow _createPhraseRow({
      required NotePhrase phrase,
    }) {
      final nn = Provider.of<NoteNotifier>(context);

      return TableRow(
        children: [
          TableCell(
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  _showAchievePhraseConfirmDialog(
                    message: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Achieved Listに移しますか?\n'),
                        Text(
                          'japanese',
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                        ),
                        Text(
                          '    ${phrase.japanese}',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                        Text(
                          'english',
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                        ),
                        Text(
                          '    ${phrase.english}',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ],
                    ),
                    onAchieve: () => nn.achievePhrase(
                      noteId: widget.note.id,
                      phraseId: phrase.id,
                    ),
                    onCancel: () =>
                        {InAppLogger.debug('cancel achieve phrase: $phrase')},
                  );
                },
              ),
            ).padding(),
          ),
          TableCell(
            child: !nn.canSeeJapanese
                ? Container()
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        builder: (BuildContext context, _) => EditPhrase(
                          language: Language.japanese,
                          notePhrase: phrase,
                          onSubmit: (String text) {
                            final nn = Provider.of<NoteNotifier>(
                              context,
                              listen: false,
                            );
                            phrase.japanese = text;
                            nn.updatePhraseInNote(
                              noteId: nn.nowSelectedNoteId,
                              phraseId: phrase.id,
                              phrase: phrase,
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    child: Container(
                      child: Center(
                        child: Text('${phrase.japanese}').padding(),
                      ).padding(),
                    ),
                  ),
          ),
          TableCell(
            child: !nn.canSeeEnglish
                ? Container()
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        builder: (BuildContext context, _) => EditPhrase(
                          language: Language.america,
                          notePhrase: phrase,
                          onSubmit: (String text) {
                            final nn = Provider.of<NoteNotifier>(
                              context,
                              listen: false,
                            );
                            phrase.english = text;
                            nn.updatePhraseInNote(
                              noteId: nn.nowSelectedNoteId,
                              phraseId: phrase.id,
                              phrase: phrase,
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    child: Container(
                      child: Center(
                        child: Text('${phrase.english}').padding(),
                      ).padding(),
                    ),
                  ),
          ),
        ],
      );
    }

    // TODO: DataTableのほうがいい?
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
            .map((phrase) => _createPhraseRow(phrase: phrase))
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

    return widget.note.isAchievedNote
        ? Column(children: [title, AchievedPhraseList()])
        : Column(
            children: [
              title,
              header,
              phrasesTable.padding(),
              if (!widget.note.isDefaultNote && !widget.note.isAchievedNote)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: _deleteNoteButton,
                ),
            ],
          );
  }
}
