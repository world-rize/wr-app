// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_phrase_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePhraseList _$FavoritePhraseListFromJson(Map json) {
  return FavoritePhraseList(
    id: json['id'] as String,
    title: json['title'] as String,
    sortType: json['sortType'] as String,
    isDefault: json['isDefault'] as bool,
    favoritePhraseIds: (json['favoritePhraseIds'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          e == null
              ? null
              : FavoritePhraseDigest.fromJson((e as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    ),
  );
}

Map<String, dynamic> _$FavoritePhraseListToJson(FavoritePhraseList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortType': instance.sortType,
      'isDefault': instance.isDefault,
      'favoritePhraseIds':
          instance.favoritePhraseIds?.map((k, e) => MapEntry(k, e?.toJson())),
    };
