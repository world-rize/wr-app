// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/article/category.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/store/articles.dart';
import 'package:wr_app/ui/column/article_overview.dart';

/// カテゴリ内記事一覧
class CategoryPosts extends StatelessWidget {
  CategoryPosts({
    @required this.category,
    @required this.onTap,
  });

  final Category category;
  final Function(Article) onTap;

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<ArticleStore>(context).repo;
    final primaryColor = Theme.of(context).primaryColor;

    final articleNotFound = Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.grey,
            ),
            Text(
              '記事がありません',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

    // TODO(someone): caching
    final articlesView = FutureBuilder<List<Article>>(
      future: repo.findByCategory(category.id),
      builder: (_, snapshot) {
        return Stack(
          children: <Widget>[
//            if (!snapshot.hasData)
//              Center(
//                child: OverlayLoading(loading: !snapshot.hasData),
//              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (snapshot.hasData && snapshot.data.isNotEmpty)
                  ...snapshot.data
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
                  articleNotFound,
              ],
            ),
          ],
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('${category.title}'),
      ),
      body: SingleChildScrollView(
        child: articlesView,
      ),
    );
  }
}
