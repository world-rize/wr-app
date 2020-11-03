// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// ロック中の要素
class LockedView extends StatelessWidget {
  const LockedView({required this.child, this.locked = false});

  final Widget child;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        if (locked)
          ClipRect(
            child: Container(
              color: Colors.black12.withOpacity(0.4),
            ),
          ),
        if (locked)
          Container(
            child: Center(
              child: Icon(
                Icons.lock,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
      ],
    );
  }
}
