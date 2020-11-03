// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  LoadingView({
    required this.child,
    required this.loading,
    this.color = Colors.white,
  });

  bool loading;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        children: [
          child,
          if (loading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
