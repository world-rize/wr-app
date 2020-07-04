// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_contentful.g.dart';

/// 記事のcontentfulモデル
@JsonSerializable()
class NewArticle extends Entry<ArticleFields> {
  NewArticle({
    SystemFields sys,
    ArticleFields fields,
  }) : super(sys: sys, fields: fields);

  static NewArticle fromJson(Map<String, dynamic> json) =>
      _$NewArticleFromJson(json);

  Map<String, dynamic> toJson() => _$NewArticleToJson(this);
}

/// 記事
@JsonSerializable()
class ArticleFields extends Equatable {
  const ArticleFields({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.category,
    @required this.tags,
    @required this.content,
    @required this.createdat,
    @required this.assets,
  }) : super();

  factory ArticleFields.fromJson(Map<String, dynamic> json) =>
      _$ArticleFieldsFromJson(json);

  /// id
  final String id;

  /// タイトル
  final String title;

  /// サブタイトル
  final String subtitle;

  /// カテゴリ
  final String category;

  /// タグ(,区切り)
  final List<String> tags;

  /// 内容(マークダウンを想定?)
  final String content;

  /// 投稿日時
  final DateTime createdat;

  /// 外部URL
  final List<Asset> assets;

  Map<String, dynamic> toJson() => _$ArticleFieldsToJson(this);

  @override
  List<Object> get props => [title];
}
