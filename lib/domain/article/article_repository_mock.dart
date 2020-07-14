// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/article_repository.dart';
import 'package:wr_app/domain/article/model/article.dart';
import 'package:wr_app/domain/article/model/category.dart';

class ArticleMockRepository implements IArticleRepository {
  @override
  Future<List<ArticleDigest>> findByCategory(
      Client client, String category) async {
    return List.generate(100, (index) {
      final category = [
        'online_lesson',
        'article',
        'random',
        'listening',
        'comics',
        'cuisine'
      ][index % 6];
      return ArticleDigest.fromMock(
          title: 'Article $category ${index ~/ 6}',
          url: 'https://world-rize.com/working-in-hotel-in-sydney/',
          summary: 'Article $category summary');
    });
  }

  @override
  List<ArticleCategory> getCategories() {
    return categories;
  }
}
