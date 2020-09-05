// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

class FlashCardController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      color: Colors.grey,
      child: Column(
        children: [
          Text('ボタンとかたくさん'),
        ],
      ),
    );
  }
}
