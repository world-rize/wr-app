// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// 記事カテゴリ
@JsonSerializable()
class ArticleCategory {
  ArticleCategory({
    @required this.id,
    @required this.title,
    @required this.thumbnailUrl,
  });

  factory ArticleCategory.fromJson(Map<String, dynamic> json) =>
      _$ArticleCategoryFromJson(json);

  /// id
  final String id;

  /// タイトル
  final String title;

  /// サムネ
  final String thumbnailUrl;

  Map<String, dynamic> toJson() => _$ArticleCategoryToJson(this);
}
