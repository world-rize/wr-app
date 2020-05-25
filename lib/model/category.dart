// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// 記事カテゴリ
@JsonSerializable()
class Category {
  Category({
    @required this.id,
    @required this.title,
    @required this.thumbnailUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// id
  final String id;

  /// タイトル
  final String title;

  /// サムネ
  final String thumbnailUrl;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
