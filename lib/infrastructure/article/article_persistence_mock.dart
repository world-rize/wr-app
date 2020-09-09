// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/index.dart';

final List<ArticleCategory> categories = <ArticleCategory>[
  ArticleCategory(
    id: 'online_lesson',
    title: 'オンライン英会話',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  ArticleCategory(
    id: 'article',
    title: 'Articles',
    thumbnailUrl: 'assets/thumbnails/article.jpg',
  ),
  ArticleCategory(
    id: 'random',
    title: 'Random facts',
    thumbnailUrl: 'assets/thumbnails/facts.png',
  ),
  ArticleCategory(
    id: 'listening',
    title: 'Listening Practice',
    thumbnailUrl: 'assets/thumbnails/listening.jpg',
  ),
  ArticleCategory(
    id: 'comics',
    title: 'Comics',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  ArticleCategory(
    id: 'cuisine',
    title: 'cuisine from around the world',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
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
