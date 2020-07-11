// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part './article.g.dart';

/// 記事
@JsonSerializable()
class Article extends Entry<ArticleFields> {
  Article({
    SystemFields sys,
    ArticleFields fields,
  }) : super(sys: sys, fields: fields);

  Article.fromMock({String title, String content})
      : super(
          sys: null,
          fields: ArticleFields(
            id: 'aaa',
            title: title,
            subtitle: '',
            category: '',
            tags: const <String>[],
            content: content,
            createdat: DateTime.now(),
            assets: const <Asset>[],
          ),
        );

  static Article fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
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
  final dynamic content;

  /// 投稿日時
  final DateTime createdat;

  /// 外部URL
  final List<Asset> assets;

  Map<String, dynamic> toJson() => _$ArticleFieldsToJson(this);

  @override
  List<Object> get props => [title];
}
