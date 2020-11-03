// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: child,
      ),
    );
  }
}
