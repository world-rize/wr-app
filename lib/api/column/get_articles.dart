// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:wr_app/model/column/article.dart';

/// ダミー記事
List<Article> dummyArticles = [
  Article.internal(
      id: 'article_001',
      title: 'Article1',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      content: '''
# Hello, World
hogehoge

    '''),
  Article.internal(
      id: 'article_002',
      title: 'Article2',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      content: '''
# Hello, World
hogehoge

    '''),
  Article.internal(
      id: 'article_003',
      title: 'Article3',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
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
  ),
  Article.external(
    id: 'tips_001',
    title: '視覚で捉える！！前置詞マスター講座＃0【導入編】',
    thumbnailUrl:
        'https://world-rize.com/wp-content/themes/jstork/library/images/noimg.png',
    date: DateTime.now(),
  ),
];

/// 記事一覧を取得するAPI
Future<List<Article>> getArticles(String category) async {
  await Future.delayed(const Duration(seconds: 1));

  final res = dummyArticles
      .where((article) => article.id.startsWith(category))
      .toList();

  return Future.value(res);
}

/// 記事を取得するAPI
Future<Article> getArticle(String id) async {
  await Future.delayed(const Duration(seconds: 1));

  final res = dummyArticles.firstWhere((article) => article.id == id);

  return Future.value(res);
}

//  static Article fromMarkdown(String src) {
//    final doc = parse(src);
//    return Article.internal(
//      title: doc.data['title'],
//      content: doc.content,
//    );
//  }
