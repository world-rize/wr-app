// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:wr_app/model/column/article.dart';

/// 記事本文
class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final h1 = Theme.of(context).primaryTextTheme.headline1;
    final primaryColor = Theme.of(context).primaryColor;

    final headline = Stack(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 100,
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
      body: LayoutBuilder(builder: (_, c) {
        return SizedBox(
          height: c.maxHeight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                headline,
                Markdown(
                  shrinkWrap: true,
                  selectable: true,
                  physics: const NeverScrollableScrollPhysics(),
                  data: article.content,
                  imageDirectory: 'https://raw.githubusercontent.com',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
