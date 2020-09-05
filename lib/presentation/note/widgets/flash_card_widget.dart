// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// NotePhrase を表示するウィジェット
class FlashCard extends StatefulWidget {
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  bool _flipped;

  @override
  void initState() {
    super.initState();
    _flipped = false;
  }

  @override
  Widget build(BuildContext context) {
    final h1 = Theme.of(context).textTheme.headline2;

    return GestureDetector(
      onTap: () {
        setState(() {
          _flipped = !_flipped;
        });
      },
      child: ShadowedContainer(
        color: Colors.grey,
        child: Stack(
          children: [
            const Positioned(
              right: 10,
              bottom: 10,
              child: Icon(
                FontAwesome5.star,
                size: 40,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(_flipped ? 'うら' : 'おもて', style: h1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
