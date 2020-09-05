// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

class AddPhraseDialog extends StatefulWidget {
  AddPhraseDialog({@required this.onSubmit, @required this.onCancel});

  Function(NotePhrase) onSubmit;
  Function onCancel;

  @override
  _AddPhraseDialogState createState() =>
      _AddPhraseDialogState(onSubmit: onSubmit, onCancel: onCancel);
}

class _AddPhraseDialogState extends State<AddPhraseDialog> {
  _AddPhraseDialogState({@required this.onSubmit, @required this.onCancel});

  String _word;
  String _translation;
  Function(NotePhrase) onSubmit;
  Function onCancel;

  @override
  void initState() {
    super.initState();
    _word = '';
    _translation = '';
  }

  @override
  Widget build(BuildContext context) {
    final wordField = TextFormField(
      onChanged: (String tmpWord) {
        setState(() {
          _word = tmpWord;
        });
      },
      decoration: const InputDecoration(labelText: 'english'),
    );

    final translationField = TextFormField(
      onChanged: (String tmpTranslation) {
        setState(() {
          _translation = tmpTranslation;
        });
      },
      decoration: const InputDecoration(labelText: '日本語'),
    );

    final okButton = RaisedButton(
      child: const Text('Create'),
      onPressed: () {
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
      title: const Text('New Phrase'),
      content: form,
      actions: [
        cancelButton,
        okButton,
      ],
    );
  }
}
