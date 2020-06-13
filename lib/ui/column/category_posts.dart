// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/model/article.dart';
import 'package:wr_app/model/category.dart';
import 'package:wr_app/ui/column/article_overview.dart';

/// カテゴリ内記事一覧
class CategoryPosts extends StatelessWidget {
  const CategoryPosts({
    @required this.category,
    @required this.articles,
    @required this.onTap,
  });

  final Category category;
  final List<Article> articles;
  final Function(Article) onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('${category.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//            Padding(
//              padding: const EdgeInsets.all(10),
//              child: GFTypography(
//                text: '${category.title}の記事一覧',
//                type: GFTypographyType.typo1,
//                dividerColor: GFColors.SUCCESS,
//              ),
//            ),
            if (articles.isNotEmpty)
              ...articles
                  .map(
                    (article) => GestureDetector(
                      onTap: () {
                        onTap(article);
                      },
                      child: ArticleOverView(article: article),
                    ),
                  )
                  .toList()
            else
              const Text('記事がありません'),
          ],
        ),
      ),
    );
  }
}
