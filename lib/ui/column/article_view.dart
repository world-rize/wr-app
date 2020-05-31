// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/model/article.dart';

/// 記事本文
class ArticleContentView extends StatelessWidget {
  const ArticleContentView({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final h1 = Theme.of(context).primaryTextTheme.headline1;
    final primaryColor = Theme.of(context).primaryColor;

    final headline = Stack(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            article.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              article.title,
              style: h1,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('${article.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            headline,
            Flexible(
              child: Markdown(
                selectable: true,
                physics: const NeverScrollableScrollPhysics(),
                data: article.content,
                imageDirectory: 'https://raw.githubusercontent.com',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 記事見出し
class ArticleView extends StatelessWidget {
  const ArticleView({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              article.thumbnailUrl,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: Icon(Icons.label),
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
                        builder: (_) => ArticleContentView(article: article),
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
