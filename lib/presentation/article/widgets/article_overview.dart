// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/article/pages/article_webview_page.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// 記事見出し
class ArticleOverView extends StatelessWidget {
  const ArticleOverView({
    @required this.articleDigest,
  });

  final ArticleDigest articleDigest;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryTextTheme;
    final backgroundColor = Theme.of(context).backgroundColor;

    final tagsView = Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: (articleDigest.fields.tags != null
                ? articleDigest.fields.tags.split(',')
                : [])
            .map(
              (tag) => GFBadge(
                text: tag,
                color: Colors.grey.shade500,
                shape: GFBadgeShape.square,
              ).padding(4),
            )
            .toList(),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ShadowedContainer(
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // TODO
            if (articleDigest.fields.thumbnail != null)
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Image.network(
                  articleDigest.fields.thumbnail?.fields?.file?.url,
                  fit: BoxFit.cover,
                ),
              ),

            tagsView,

            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  articleDigest.fields.title,
                  style: theme.headline2,
                ),
              ),
              subtitle: articleDigest.fields.tags != null
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        articleDigest.fields.summary,
                        style: theme.caption,
                      ),
                    )
                  : null,
            ),

            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(I.of(context).readMore),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ArticleWebViewPage(articleDigest: articleDigest),
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
