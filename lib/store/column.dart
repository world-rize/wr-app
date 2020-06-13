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
          id: 'article_001',
          title: 'Article1',
          thumbnailUrl: 'https://source.unsplash.com/category/nature',
          date: DateTime.now(),
          tags: '',
          content: '''
# Hello, World
hogehoge

    '''),
      Article.internal(
          id: 'article_002',
          title: 'Article2',
          thumbnailUrl: 'https://source.unsplash.com/category/nature',
          date: DateTime.now(),
          tags: '',
          content: '''
# Hello, World
hogehoge

    '''),
      Article.internal(
          id: 'article_003',
          title: 'Article3',
          thumbnailUrl: 'https://source.unsplash.com/category/nature',
          date: DateTime.now(),
          tags: '',
          content: '''
# Hello, World
hogehoge

    '''),
      Article.external(
        id: 'tips_002',
        title: '視覚で捉える！！前置詞マスター講座＃1【接触の前置詞on】',
        thumbnailUrl:
            'https://world-rize.com/wp-content/themes/jstork/library/images/noimg.png',
        date: DateTime.now(),
        tags: '',
      ),
      Article.external(
        id: 'tips_001',
        title: '視覚で捉える！！前置詞マスター講座＃0【導入編】',
        thumbnailUrl:
            'https://world-rize.com/wp-content/themes/jstork/library/images/noimg.png',
        date: DateTime.now(),
        tags: '',
      ),
    ]);
  }

  List<Article> articlesById(String id) {
    return _articles.where((article) => article.id.startsWith(id)).toList();
  }
}
