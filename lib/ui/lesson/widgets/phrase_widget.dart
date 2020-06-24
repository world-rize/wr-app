// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/extension/padding_extension.dart';
import 'package:wr_app/extension/string_capitalization.dart';
import 'package:wr_app/model/phrase/phrase.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// フレーズを表示するコンポーネント
class PhraseCard extends StatelessWidget {
  const PhraseCard({
    @required this.phrase,
    @required this.favorite,
    this.onTap,
  });

  final Phrase phrase;
  final bool favorite;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final englishStyle = Theme.of(context).primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;
    // final existVoice = phrase.assets.voice.isEmpty;

    return GestureDetector(
      onTap: onTap,
      child: ShadowedContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    phrase.title['en'].capitalize(),
                    style: englishStyle,
                  ).p(4),
                  Text(
                    phrase.title['ja'],
                    style: japaneseStyle,
                  ).p(4),
                ],
              ).p_1(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14, bottom: 14),
              child: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    ).p_1();
  }
}
