// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/index.dart';

final List<ArticleCategory> categories = <ArticleCategory>[
  ArticleCategory(
    id: 'online_lesson',
    title: 'オンライン英会話',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
    url: 'https://world-rize.com/category/article/',
  ),
  ArticleCategory(
    id: 'article',
    title: 'Articles',
    thumbnailUrl: 'assets/thumbnails/article.jpg',
    url: 'https://world-rize.com/category/article/',
  ),
  ArticleCategory(
    id: 'random',
    title: 'Random facts',
    thumbnailUrl: 'assets/thumbnails/facts.png',
    url: 'https://world-rize.com/category/random-facts/',
  ),
  ArticleCategory(
    id: 'useful',
    title: 'Useful information',
    thumbnailUrl: 'assets/thumbnails/useful.jpg',
    url: 'https://world-rize.com/category/useful-information/',
  )
];

class ArticlePersistenceMock implements ArticleRepository {
  @override
  Future<List<ArticleDigest>> findByCategory(
      Client client, String category) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return List.generate(10, (index) {
      return ArticleDigest.dummy(
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
