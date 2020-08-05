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

class ArticlePersistence implements ArticleRepository {
  @override
  Future<List<ArticleDigest>> findByCategory(
      Client client, String category) async {
    final collection = await client.getEntries<ArticleDigest>({
      'content_type': 'article',
      'fields.category': category,
    }, ArticleDigest.fromJson);

    return collection.items;
  }

  @override
  List<ArticleCategory> getCategories() {
    /// # categories
    /// - online_lesson
    /// - article
    /// - random
    /// - listening
    /// - comics
    /// - cuisine
    return categories;
  }
}
