// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

/// 記事
@JsonSerializable()
class ArticleDigest extends Entry<ArticleDigestFields> {
  ArticleDigest({
    @required SystemFields sys,
    @required ArticleDigestFields fields,
  }) : super(sys: sys, fields: fields);

  ArticleDigest.fromMock({
    @required String title,
    @required String category,
    @required String url,
    @required String summary,
  }) : super(
          sys: SystemFields(),
          fields: ArticleDigestFields(
            title: title,
            url: url,
            category: category,
            tags: '',
            thumbnail: Asset(
              fields: AssetFields(
                file: AssetFile(url: 'https://source.unsplash.com/random'),
              ),
            ),
            summary: summary,
          ),
        );

  static ArticleDigest fromJson(Map<dynamic, dynamic> json) =>
      _$ArticleDigestFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDigestToJson(this);
}

/// 記事
@JsonSerializable()
class ArticleDigestFields extends Equatable {
  const ArticleDigestFields({
    @required this.title,
    @required this.url,
    @required this.category,
    @required this.tags,
    @required this.thumbnail,
    @required this.summary,
  }) : super();

  factory ArticleDigestFields.fromJson(Map<dynamic, dynamic> json) =>
      _$ArticleDigestFieldsFromJson(json);

  /// タイトル
  final String title;

  /// URL
  final String url;

  /// カテゴリ
  final String category;

  /// タグ(,区切り)
  final String tags;

  final Asset thumbnail;

  final String summary;

  Map<String, dynamic> toJson() => _$ArticleDigestFieldsToJson(this);

  @override
  List<Object> get props => [title];
}
