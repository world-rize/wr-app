// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDigest _$ArticleDigestFromJson(Map<String, dynamic> json) {
  return ArticleDigest(
    sys: json['sys'] == null
        ? null
        : SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
    fields: json['fields'] == null
        ? null
        : ArticleDigestFields.fromJson(json['fields'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArticleDigestToJson(ArticleDigest instance) =>
    <String, dynamic>{
      'sys': instance.sys,
      'fields': instance.fields,
    };

ArticleDigestFields _$ArticleDigestFieldsFromJson(Map<String, dynamic> json) {
  return ArticleDigestFields(
    title: json['title'] as String,
    url: json['url'] as String,
    category: json['category'] as String,
    tags: json['tags'] as String,
    thumbnail: json['thumbnail'] == null
        ? null
        : Asset.fromJson(json['thumbnail'] as Map<String, dynamic>),
    summary: json['summary'] as String,
  );
}

Map<String, dynamic> _$ArticleDigestFieldsToJson(
        ArticleDigestFields instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'category': instance.category,
      'tags': instance.tags,
      'thumbnail': instance.thumbnail,
      'summary': instance.summary,
    };
