// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({this.label, this.onPressed});

  final Widget label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: onPressed == null ? Colors.grey : Colors.orange,
      onPressed: onPressed,
      label: label,
    );
  }
}
