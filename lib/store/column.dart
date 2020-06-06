// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart' as foundation;
import 'package:wr_app/model/article.dart';
import 'package:wr_app/model/category.dart';

class ArticleStore with foundation.ChangeNotifier {
  factory ArticleStore() {
    return _cache;
  }

  /// シングルトンインスタンス
  static final ArticleStore _cache = ArticleStore._internal();

  final List<Category> categories = [];

  static final List<Article> _articles = [];

  /// ストアの初期化
  /// 一度しか呼ばれない
  ArticleStore._internal() {
    categories.addAll([
      Category(
        id: 'online_lesson',
        title: 'オンライン英会話',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
      Category(
        id: 'article',
        title: '記事',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
      Category(
        id: 'listening',
        title: 'Listening Practice',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
      Category(
        id: 'illust',
        title: '絵付き漫画',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
      Category(
        id: 'dish',
        title: '世界の料理',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
      Category(
        id: 'tips',
        title: '前置詞',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
    ]);

    _articles.addAll([
      Article.internal(
          id: 'abcd_efgh_0000',
          title: 'Hello, World',
          thumbnailUrl: 'https://source.unsplash.com/category/nature',
          date: DateTime.now(),
          tags: 'AAA,BBB,CCC',
          content: '''
# Hello, World
hogehoge

    '''),
      Article.internal(
          id: 'abcd_efgh_0000',
          title: 'Hello, World',
          thumbnailUrl: 'https://source.unsplash.com/category/nature',
          date: DateTime.now(),
          tags: 'AAA,BBB,CCC',
          content: '''
# Hello, World
hogehoge

    '''),
      Article.internal(
          id: 'abcd_efgh_0000',
          title: 'Hello, World',
          thumbnailUrl: 'https://source.unsplash.com/category/nature',
          date: DateTime.now(),
          tags: 'AAA,BBB,CCC',
          content: '''
# Hello, World
hogehoge

    '''),
    ]);
  }

  List<Article> articlesById(String id) {
    return _articles;
  }
}
