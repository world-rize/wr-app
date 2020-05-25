// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/model/article.dart';

/// 記事本文
class ArticleContentView extends StatelessWidget {
  const ArticleContentView({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final h1 = Theme.of(context).primaryTextTheme.headline1;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('${article.title}'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.network(article.thumbnailUrl),
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
              ),
            ],
          ),
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
          Image.network(article.thumbnailUrl),
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
              FlatButton(
                child: const Text('続きを読む'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleContentView(article: article),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
