// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

/// 記事
@JsonSerializable()
class Article {
  Article({
    @required this.id,
    @required this.title,
    @required this.thumbnailUrl,
    @required this.date,
    @required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// id
  final String id;

  /// タイトル
  final String title;

  /// 投稿日時
  final DateTime date;

  /// サムネ
  final String thumbnailUrl;

  /// 内容(マークダウンを想定?)
  final String content;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
