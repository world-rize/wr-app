// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/ui/column/pages/article_detail_page.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// 記事見出し
class ArticleOverView extends StatelessWidget {
  const ArticleOverView({this.article});

  final ArticleDigest article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryTextTheme;

    print(article.fields.toJson()['assets']);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ShadowedContainer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // TODO
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Image.network(
                '',
                fit: BoxFit.cover,
              ),
            ),
//          Padding(
//            padding: const EdgeInsets.all(8),
//            child: Row(
//              children: article.tags
//                  .split(',')
//                  .map((tag) => GFButtonBadge(
//                        text: tag,
//                        color: Colors.grey.shade500,
//                        shape: GFButtonShape.square,
//                        type: GFButtonType.outline,
//                      ).p(4))
//                  .toList(),
//            ),
//          ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  article.fields.title,
                  style: theme.headline2,
                ),
              ),
              subtitle: article.fields.tags != null
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        article.fields.tags,
                        style: theme.headline4,
                      ),
                    )
                  : null,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('続きを読む'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticleDetailPage(article: article),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
