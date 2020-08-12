// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.text,
    this.color,
    this.onTap,
  });

  final String text;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      color: color,
      disabledColor: Colors.black,
      shape: StadiumBorder(
        side: BorderSide(
          color: color,
        ),
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
