// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({@required this.label, @required this.onPressed});

  final Widget label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: onPressed == null ? Colors.grey : Palette.primaryOrange,
      onPressed: onPressed,
      label: label,
    );
  }
}
