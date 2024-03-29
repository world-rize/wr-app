// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class ShadowedContainer extends StatelessWidget {
  const ShadowedContainer({
    @required this.child,
    @required this.color,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
