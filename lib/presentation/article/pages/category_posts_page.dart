// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';

import './article_webview_page.dart';
import '../widgets/article_overview.dart';

/// Column > index > category_posts
class CategoryPosts extends StatelessWidget {
  CategoryPosts({
    @required this.category,
  });

  final ArticleCategory category;

  List<Widget> _createPostsView(
      BuildContext context, List<ArticleDigest> digests) {
    print(digests.map((d) => d.toJson()));

    return digests
        .map(
          (articleDigest) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ArticleWebViewPage(articleDigest: articleDigest),
                ),
              );
            },
            child: ArticleOverView(articleDigest: articleDigest),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ArticleNotifier>(context);
    final primaryColor = Theme.of(context).primaryColor;

    final articleNotFound = Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const <Widget>[
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!snapshot.hasData)
                  // Loading
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (snapshot.data == null || snapshot.data.isEmpty)
                  articleNotFound
                else
                  ..._createPostsView(context, snapshot.data),
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
