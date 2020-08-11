// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseList _$PhraseListFromJson(Map json) {
  return PhraseList(
    id: json['id'] as String,
    title: json['title'] as String,
    sortType: json['sortType'] as String,
    isDefault: json['isDefault'] as bool,
    phrases: (json['phrases'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          e == null
              ? null
              : Phrase.fromJson((e as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    ),
  );
}

Map<String, dynamic> _$PhraseListToJson(PhraseList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortType': instance.sortType,
      'isDefault': instance.isDefault,
      'phrases': instance.phrases?.map((k, e) => MapEntry(k, e?.toJson())),
    };
