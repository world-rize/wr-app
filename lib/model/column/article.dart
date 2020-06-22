// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/model/column/article_type.dart';

part 'article.g.dart';

/// 記事
@JsonSerializable()
class Article {
  Article({
    @required this.id,
    @required this.type,
    @required this.title,
    @required this.thumbnailUrl,
    @required this.date,
    @required this.content,
    @required this.url,
  });

  /// アプリ内で読める記事
  Article.internal({
    String id,
    @required String title,
    String thumbnailUrl,
    DateTime date,
    @required String content,
  }) : this(
          id: id,
          type: ArticleType.inApp,
          title: title,
          thumbnailUrl: thumbnailUrl,
          date: date,
          content: content,
          url: '',
        );

  /// 外部記事
  Article.external({
    String id,
    String title,
    String thumbnailUrl,
    DateTime date,
    String url,
  }) : this(
          id: id,
          type: ArticleType.external,
          title: title,
          thumbnailUrl: thumbnailUrl,
          date: date,
          content: '',
          url: url,
        );

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// id
  final String id;

  /// type
  final ArticleType type;

  /// タイトル
  final String title;

  /// 投稿日時
  final DateTime date;

  /// サムネ
  final String thumbnailUrl;

  /// 内容(マークダウンを想定?)
  final String content;

  /// 外部URL
  final String url;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
