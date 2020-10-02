// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/note/widgets/note_table.dart';

/// `ノート` ページのトップ
///
class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // default note
    final un = Provider.of<UserNotifier>(context);
    final nn = Provider.of<NoteNotifier>(context);
    final theme = Theme.of(context);

    // 最初はデフォルトを設定
    if (nn.nowSelectedNoteId.isEmpty) {
      nn.nowSelectedNoteId = un.user.getDefaultNote().id;
    }

    final note = nn.currentNote ?? un.user.getDefaultNote();
    assert(note != null);

    final _noteNotFoundView = Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          'ノートがありません',
          style: theme.textTheme.headline5.apply(color: Colors.grey),
        ),
      ),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          // TODO: scaffoldを自前クラスを作ったほうがいいかも
          // bottom navigationがstackを利用しているためにpaddingを入れる必要がある
          padding: EdgeInsets.only(bottom: 30),
          controller: _controller,
          child: note == null
              ? _noteNotFoundView
              : NoteTable(
                  note: note,
                  onDeleted: () {
                    _controller.animateTo(
                      0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
