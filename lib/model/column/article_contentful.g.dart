// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_contentful.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewArticle _$NewArticleFromJson(Map<String, dynamic> json) {
  return NewArticle(
    sys: json['sys'] == null
        ? null
        : SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
    fields: json['fields'] == null
        ? null
        : ArticleFields.fromJson(json['fields'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewArticleToJson(NewArticle instance) =>
    <String, dynamic>{
      'sys': instance.sys,
      'fields': instance.fields,
    };

ArticleFields _$ArticleFieldsFromJson(Map<String, dynamic> json) {
  return ArticleFields(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    category: json['category'] as String,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    content: json['content'] as String,
    createdat: json['createdat'] == null
        ? null
        : DateTime.parse(json['createdat'] as String),
    assets: (json['assets'] as List)
        ?.map(
            (e) => e == null ? null : Asset.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArticleFieldsToJson(ArticleFields instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'category': instance.category,
      'tags': instance.tags,
      'content': instance.content,
      'createdat': instance.createdat?.toIso8601String(),
      'assets': instance.assets,
    };
