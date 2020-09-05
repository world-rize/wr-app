// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

class PhraseEditDialog extends StatefulWidget {
  PhraseEditDialog({
    this.phrase,
    this.onDelete,
    @required this.onSubmit,
    @required this.onCancel,
  });

  NotePhrase phrase;
  Function(NotePhrase) onSubmit;
  Function(NotePhrase) onDelete;
  Function onCancel;

  @override
  _PhraseEditDialogState createState() => _PhraseEditDialogState(
        editingPhrase: phrase,
        onSubmit: onSubmit,
        onDelete: onDelete,
        onCancel: onCancel,
      );
}

class _PhraseEditDialogState extends State<PhraseEditDialog> {
  _PhraseEditDialogState({
    this.editingPhrase,
    @required this.onSubmit,
    @required this.onDelete,
    @required this.onCancel,
  });

  String _word;
  String _translation;
  NotePhrase editingPhrase;
  Function(NotePhrase) onSubmit;
  Function(NotePhrase) onDelete;
  Function onCancel;

  @override
  void initState() {
    super.initState();
    _word = editingPhrase?.word ?? '';
    _translation = editingPhrase?.translation ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final wordField = TextFormField(
      initialValue: _word,
      onChanged: (String tmpWord) {
        setState(() {
          _word = tmpWord;
        });
      },
      decoration: const InputDecoration(labelText: 'english'),
    );

    final translationField = TextFormField(
      initialValue: _translation,
      onChanged: (String tmpTranslation) {
        setState(() {
          _translation = tmpTranslation;
        });
      },
      decoration: const InputDecoration(labelText: '日本語'),
    );

    final okButton = RaisedButton(
      child:
          editingPhrase != null ? const Text('Update') : const Text('Create'),
      onPressed: () {
        if (editingPhrase == null) {
          // create phrase
          final uuid = Uuid().v4();
          onSubmit(
            NotePhrase(
              id: uuid,
              word: _word,
              translation: _translation,
              achieved: false,
            ),
          );
        } else {
          // update phrase
          onSubmit(
            NotePhrase(
              id: editingPhrase.id,
              word: _word,
              translation: _translation,
              achieved: editingPhrase.achieved,
            ),
          );
        }
      },
    );

    final deleteButton = RaisedButton(
      child: const Text('Delete'),
      onPressed: () => onDelete(editingPhrase),
    );

    final cancelButton = RaisedButton(
      child: const Text('Cancel'),
      onPressed: onCancel,
    );

    final form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          wordField,
          translationField,
        ],
      ),
    );

    return AlertDialog(
      title: editingPhrase == null
          ? const Text('New Phrase')
          : const Text('Edit Phrase'),
      content: form,
      actions: [
        if (editingPhrase != null) deleteButton,
        cancelButton,
        okButton,
      ],
    );
  }
}
