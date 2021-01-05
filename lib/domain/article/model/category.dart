// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// 記事カテゴリ
@JsonSerializable()
class ArticleCategory {
  ArticleCategory({
    @required this.id,
    @required this.title,
    @required this.thumbnailUrl,
    @required this.url,
  });

  factory ArticleCategory.fromJson(Map<dynamic, dynamic> json) =>
      _$ArticleCategoryFromJson(json);

  /// id
  final String id;

  /// タイトル
  final String title;

  /// サムネ
  final String thumbnailUrl;

  /// カテゴリURL
  final String url;

  Map<String, dynamic> toJson() => _$ArticleCategoryToJson(this);
}
