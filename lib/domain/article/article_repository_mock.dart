// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/article_repository.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/domain/article/model/category.dart';

class ArticleMockRepository implements IArticleRepository {
  @override
  Future<List<ArticleDigest>> findByCategory(
      Client client, String category) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return List.generate(10, (index) {
      return ArticleDigest.fromMock(
        title: 'Article $category ${index ~/ 6}',
        category: category,
        url: 'https://world-rize.com/working-in-hotel-in-sydney/',
        summary: 'Article $category summary',
      );
    });
  }

  @override
  List<ArticleCategory> getCategories() {
    return categories;
  }
}
