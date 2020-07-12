// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleCategory _$ArticleCategoryFromJson(Map<String, dynamic> json) {
  return ArticleCategory(
    id: json['id'] as String,
    title: json['title'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
  );
}

Map<String, dynamic> _$ArticleCategoryToJson(ArticleCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
    };
