// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class NoteEditDialog extends StatefulWidget {
  NoteEditDialog({
    required this.onSubmit,
    required this.onCancel,
  });

  void Function(String) onSubmit;
  void Function() onCancel;

  @override
  _NoteEditDialogState createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  late String _title;

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
      onPressed: widget.onCancel,
    );

    final okButton = FlatButton(
      textColor: Colors.blueAccent,
      child: const Text('Create'),
      onPressed: () {
        widget.onSubmit(_title);
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
