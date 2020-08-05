// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/ui/column/pages/article_webview_page.dart';
import 'package:wr_app/ui/column/widgets/article_overview.dart';

/// Column > index > category_posts
class CategoryPosts extends StatelessWidget {
  CategoryPosts({
    @required this.category,
  });

  final ArticleCategory category;

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ArticleNotifier>(context);
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
    final articlesView = FutureBuilder<List<ArticleDigest>>(
      future: notifier.findByCategory(id: category.id),
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
                            //    Navigator.of(context).push(
                            //      MaterialPageRoute(
                            //        builder: (_) => ArticleDetailPage(article: article),
                            //      ),
                            //    );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArticleWebViewPage(article: article),
                              ),
                            ); // open webview
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
