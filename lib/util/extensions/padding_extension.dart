// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget padding([double padding = 8]) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }
}
