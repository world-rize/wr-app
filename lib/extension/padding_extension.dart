// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget p_1() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: this,
    );
  }
}
