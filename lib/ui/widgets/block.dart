// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final List<Widget> children;

  Block({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
