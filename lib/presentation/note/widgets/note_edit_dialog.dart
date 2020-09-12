// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';

class NoteEditDialog extends StatefulWidget {
  NoteEditDialog({
    @required this.onSubmit,
    @required this.onCancel,
  });

  Function(Note) onSubmit;
  Function onCancel;

  @override
  _NoteEditDialogState createState() =>
      _NoteEditDialogState(onCancel: onCancel, onSubmit: onSubmit);
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  _NoteEditDialogState({
    @required this.onSubmit,
    @required this.onCancel,
  });

  Function(Note) onSubmit;
  Function onCancel;
  String _title;

  @override
  void initState() {
    super.initState();
    _title = '';
  }

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      initialValue: _title,
      onChanged: (String tmpTitle) {
        setState(() {
          _title = tmpTitle;
        });
      },
      decoration: const InputDecoration(labelText: 'title'),
    );

    final cancelButton = FlatButton(
      textColor: Colors.blueAccent,
      child: const Text('Cancel'),
      onPressed: onCancel,
    );

    final okButton = FlatButton(
      textColor: Colors.blueAccent,
      child: const Text('Create'),
      onPressed: () {
        // create phrase
        final uuid = Uuid().v4();
        onSubmit(
          Note(
            id: uuid,
            title: _title,
            phrases: [],
            sortType: 'createdAt+',
            isDefault: false,
          ),
        );
      },
    );

    final form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleField,
        ],
      ),
    );

    return AlertDialog(
      title: const Text('New Note'),
      content: form,
      actions: [
        cancelButton,
        okButton,
      ],
    );
  }
}
