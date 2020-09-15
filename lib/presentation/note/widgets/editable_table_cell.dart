// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/util/extensions.dart';

class EditableTableCell extends StatelessWidget {
  EditableTableCell({
    @required this.disabled,
    @required this.value,
    @required this.onChanged,
  });

  bool disabled;
  String value;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: disabled
          ? Container()
          : Container(
              child: TextFormField(
                initialValue: value,
                decoration: const InputDecoration.collapsed(hintText: ''),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: onChanged,
              ).padding(),
            ),
    );
  }
}
