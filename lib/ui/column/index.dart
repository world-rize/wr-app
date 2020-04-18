// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// 記事
class Article {
  Article({
    @required this.title,
    @required this.date,
    @required this.content,
  });

  /// タイトル
  final String title;

  /// 投稿日時
  final DateTime date;

  /// 内容(マークダウンを想定?)
  final String content;
}

/// `コラム` ページのトップ
///
/// **未実装**
class ColumnIndexPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget _titleCreate() {
    
  }

  Widget _articleView(Article article) {
    return Column(
      children: <Widget>[
        // thumbnail
        Container(
          constraints: const BoxConstraints.expand(height: 180, width: 380),
          padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  NetworkImage('https://source.unsplash.com/category/nature'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Stack(
            children: const <Widget>[
              Positioned(
                left: 0,
                top: 16,
                child: Text(
                  'Title',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Text(
                  '100/350',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        // contents
        const Placeholder(
          fallbackHeight: 200,
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network('https://source.unsplash.com/category/nature'),
      ),
    );
  }

  

  final List<Article> articles = List.generate(
      5,
      (i) => Article(
            title: 'これは記事$iです',
            date: DateTime.now(),
            content: '''
    # 見出し
    ## 小見出し
    内容$iです
    ''',
          ));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: articles.map(_articleView).toList(),
      ),
    );
  }
}
