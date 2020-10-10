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
  List<ArticleCategory> getCategories() {
    return categories;
  }
}
