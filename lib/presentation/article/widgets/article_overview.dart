// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/presentation/article/pages/article_webview_page.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// 記事見出し
class ArticleOverView extends StatelessWidget {
  const ArticleOverView({
    @required this.article,
  });

  final ArticleDigest article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryTextTheme;
    final backgroundColor = Theme.of(context).backgroundColor;

    print(article.fields.summary);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ShadowedContainer(
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // TODO
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Image.network(
                article.fields.thumbnail.fields.file.url,
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
                        article.fields.summary,
                        style: theme.caption,
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
                        builder: (_) => ArticleWebViewPage(article: article),
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
