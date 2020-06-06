// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/model/article.dart';
import 'package:wr_app/ui/column/article_detail_page.dart';

/// 記事見出し
class ArticleOverView extends StatelessWidget {
  const ArticleOverView({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
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
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                article.title,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                article.content,
                maxLines: 3,
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
    );
  }
}
