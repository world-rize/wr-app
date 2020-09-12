// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/language.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

class PhraseEditDialog extends StatefulWidget {
  PhraseEditDialog({
    this.phrase,
    this.onDelete,
    @required this.onSubmit,
    @required this.onCancel,
    @required this.language,
  });

  NotePhrase phrase;
  Function(NotePhrase) onSubmit;
  Function(NotePhrase) onDelete;
  Function onCancel;
  Language language;

  @override
  _PhraseEditDialogState createState() => _PhraseEditDialogState(
        editingPhrase: phrase,
        onSubmit: onSubmit,
        onDelete: onDelete,
        onCancel: onCancel,
        language: language,
      );
}

class _PhraseEditDialogState extends State<PhraseEditDialog> {
  _PhraseEditDialogState({
    this.editingPhrase,
    @required this.onSubmit,
    @required this.onDelete,
    @required this.onCancel,
    @required this.language,
  });

  NotePhrase editingPhrase;
  Function(NotePhrase) onSubmit;
  Function(NotePhrase) onDelete;
  Function onCancel;
  Language language;
  String _tmpText;

  @override
  void initState() {
    super.initState();
    switch (language) {
      case Language.japanese:
        _tmpText = editingPhrase?.translation ?? '';
        break;
      case Language.america:
        _tmpText = editingPhrase?.word ?? '';
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textField;
    switch (language) {
      case Language.japanese:
        textField = TextFormField(
          initialValue: _tmpText,
          onChanged: (String tmpText) {
            setState(() {
              _tmpText = tmpText;
            });
          },
          decoration: const InputDecoration(labelText: 'japanese'),
        );
        break;
      case Language.america:
        textField = TextFormField(
          initialValue: _tmpText,
          onChanged: (String tmpText) {
            setState(() {
              _tmpText = tmpText;
            });
          },
          decoration: const InputDecoration(labelText: 'english'),
        );
        break;
    }

    final okButton = FlatButton(
      textColor: Colors.blueAccent,
      child:
          editingPhrase != null ? const Text('Update') : const Text('Create'),
      onPressed: () {
        if (editingPhrase == null) {
//          onSubmit(
//            NotePhrase.create(
//              word: _word,
//              translation: _translation,
//            ),
//          );
        } else {
          // update phrase
//          onSubmit(
//            NotePhrase(
//              id: editingPhrase.id,
//              word: _word,
//              translation: _translation,
//              achieved: editingPhrase.achieved,
//            ),
//          );
        }
      },
    );

    final deleteButton = FlatButton(
      textColor: Colors.blueAccent,
      child: const Text('Delete'),
      onPressed: () => onDelete(editingPhrase),
    );

    final cancelButton = FlatButton(
      textColor: Colors.blueAccent,
      child: const Text('Cancel'),
      onPressed: onCancel,
    );

    final form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //wordField,
          // translationField,
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
