// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/model/column/article.dart';

class ArticleRepository {
  ArticleRepository(this.client);
  final Client client;

  /// ダミー記事
  List<Article> dummyArticles = [
    Article.fromMock(title: 'Article1', content: '''
# Hello, World
hogehoge
    '''),
    Article.fromMock(title: 'Article2', content: '''
# Hello, World
hogehoge
    '''),
    Article.fromMock(title: 'Article3', content: '''
# Hello, World
hogehoge
    '''),
    Article.fromMock(title: 'Article4', content: '''
# Hello, World
hogehoge
    '''),
  ];

  Future<List<Article>> findByCategory(String category) async {
    final collection = await client.getEntries<Article>({
      'content_type': 'article',
      'fields.category': category,
    }, Article.fromJson);

    return collection.items;
  }
}
