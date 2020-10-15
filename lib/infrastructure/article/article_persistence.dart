// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/article/index.dart';

final List<ArticleCategory> categories = <ArticleCategory>[
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
//  ArticleCategory(
//    id: 'listening',
//    title: 'Listening Practice',
//    thumbnailUrl: 'assets/thumbnails/listening.jpg',
//  ),
//  ArticleCategory(
//    id: 'comics',
//    title: 'Comics',
//    thumbnailUrl: 'assets/thumbnails/english.jpg',
//  ),
//  ArticleCategory(
//    id: 'cuisine',
//    title: 'cuisine from around the world',
//    thumbnailUrl: 'assets/thumbnails/english.jpg',
//  ),
];

class ArticlePersistence implements ArticleRepository {
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
