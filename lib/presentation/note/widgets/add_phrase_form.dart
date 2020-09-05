// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

class AddPhraseDialog extends StatefulWidget {
  AddPhraseDialog(
      {this.phrase, @required this.onSubmit, @required this.onCancel});

  NotePhrase phrase;
  Function(NotePhrase) onSubmit;
  Function onCancel;

  @override
  _AddPhraseDialogState createState() => _AddPhraseDialogState(
        edittingPhrase: phrase,
        onSubmit: onSubmit,
        onCancel: onCancel,
      );
}

class _AddPhraseDialogState extends State<AddPhraseDialog> {
  _AddPhraseDialogState(
      {this.edittingPhrase, @required this.onSubmit, @required this.onCancel});

  String _word;
  String _translation;
  NotePhrase edittingPhrase;
  Function(NotePhrase) onSubmit;
  Function onCancel;

  @override
  void initState() {
    super.initState();
    _word = edittingPhrase?.word ?? '';
    _translation = edittingPhrase?.translation ?? '';
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
          edittingPhrase != null ? const Text('Update') : const Text('Create'),
      onPressed: () {
        if (edittingPhrase == null) {
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
              id: edittingPhrase.id,
              word: _word,
              translation: _translation,
              achieved: edittingPhrase.achieved,
            ),
          );
        }
      },
    );

    final cancelButton = RaisedButton(
      child: const Text('Cancel'),
      onPressed: onCancel,
    );

    final form = Form(
      child: Column(
        children: [
          wordField,
          translationField,
        ],
      ),
    );

    return AlertDialog(
      title: edittingPhrase == null
          ? const Text('New Phrase')
          : const Text('Edit Phrase'),
      content: form,
      actions: [
        cancelButton,
        okButton,
      ],
    );
  }
}
