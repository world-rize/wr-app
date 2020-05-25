// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
      id: json['id'] as String,
      type: _$enumDecodeNullable(_$ArticleTypeEnumMap, json['type']),
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      content: json['content'] as String,
      url: json['url'] as String);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ArticleTypeEnumMap[instance.type],
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'thumbnailUrl': instance.thumbnailUrl,
      'content': instance.content,
      'url': instance.url
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$ArticleTypeEnumMap = <ArticleType, dynamic>{
  ArticleType.inApp: 'inApp',
  ArticleType.external: 'external'
};
