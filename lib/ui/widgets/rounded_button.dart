// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.key,
    this.text,
    this.color,
    this.onTap,
  });

  final Key key;
  final String text;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: key,
      onPressed: onTap,
      color: color,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
