// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class OverlayLoading extends StatelessWidget {
  OverlayLoading({@required this.loading});

  bool loading;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              ],
            ),
          )
        : Container();
  }
}
