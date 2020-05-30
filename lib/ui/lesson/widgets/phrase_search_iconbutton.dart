// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

// TODO(someone): 検索実装
class PhraseSearchIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        print('search');
      },
    );
  }
}
