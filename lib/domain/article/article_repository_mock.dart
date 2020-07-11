// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/article_repository.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/domain/article/model/category.dart';

class ArticleMockRepository implements IArticleRepository {
  @override
  Future<List<Article>> findByCategory(Client client, String category) async {
    return <Article>[
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
  }

  @override
  List<ArticleCategory> getCategories() {
    return categories;
  }
}
