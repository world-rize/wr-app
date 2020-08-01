// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/ui/extensions.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// phrase card view
class PhraseCard extends StatelessWidget {
  const PhraseCard({
    @required this.phrase,
    @required this.favorite,
    this.onTap,
    this.onFavorite,
    this.highlight,
  });

  final Phrase phrase;
  final bool favorite;
  final Function onTap;
  final Function onFavorite;
  final Color highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final englishStyle = theme.primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;
    // final existVoice = phrase.assets.voice.isEmpty;

    return Stack(
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: highlight != null
                ? BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.03, 0.03],
                      colors: [highlight, theme.canvasColor],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  )
                : null,
            child: ShadowedContainer(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
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
                  ),
                ],
              ),
            ),
          ),
        ).p_1(),
        Positioned(
          bottom: 10,
          right: 10,
          child: GestureDetector(
            onTap: onFavorite,
            child: Padding(
              padding: const EdgeInsets.only(right: 14, bottom: 14),
              child: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
