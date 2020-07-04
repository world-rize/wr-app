// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/model/column/article.dart';
import 'package:wr_app/model/column/article_type.dart';
import 'package:wr_app/ui/column/article_detail_page.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// 記事見出し
class ArticleOverView extends StatelessWidget {
  const ArticleOverView({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryTextTheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ShadowedContainer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Image.network(
                article.thumbnailUrl,
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
                  article.title,
                  style: theme.headline2,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  article.content,
                  maxLines: 3,
                  style: theme.bodyText2,
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                if (article.type == ArticleType.inApp)
                  FlatButton(
                    child: const Text('続きを読む'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArticleDetailPage(article: article),
                        ),
                      );
                    },
                  )
                else
                  FlatButton(
                    child: const Text('Webで開く'),
                    onPressed: () async {
                      const url = 'https://world-rize.com';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                          forceWebView: false,
                        );
                      }
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
