// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// phrase card view
class PhraseCard extends StatelessWidget {
  const PhraseCard({
    required this.phrase,
    required this.favorite,
    this.onTap,
    this.onFavorite,
    this.highlight,
  });

  final Phrase phrase;
  final bool favorite;
  final void Function()? onTap;
  final void Function()? onFavorite;
  final Color? highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = Theme.of(context).backgroundColor;
    final englishStyle = theme.primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;
    final highlightDecoration = highlight != null
        ? BoxDecoration(
            color: Colors.grey,
            gradient: LinearGradient(
              stops: const [0.03, 0.03],
              colors: [highlight!, theme.canvasColor],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          )
        : null;

    final card = ShadowedContainer(
      color: backgroundColor,
      child: Container(
        decoration: highlightDecoration,
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
                      phrase.title['en']!.capitalize(),
                      style: englishStyle,
                    ).padding(4),
                    Text(
                      phrase.title['ja'],
                      style: japaneseStyle,
                    ).padding(4),
                  ],
                ).padding(),
              ),
            ),
          ],
        ),
      ),
    );

    final overlay = Positioned(
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
    );

    return Stack(
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: card,
        ).padding(),
        overlay,
      ],
    );
  }
}
