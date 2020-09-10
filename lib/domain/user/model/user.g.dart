// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    userId: json['userId'] as String,
    favorites: (json['favorites'] as Map)?.map(
      (k, e) => MapEntry(k as String,
          e == null ? null : FavoritePhraseList.fromJson(e as Map)),
    ),
    notes: (json['notes'] as Map)?.map(
      (k, e) =>
          MapEntry(k as String, e == null ? null : Note.fromJson(e as Map)),
    ),
    statistics: json['statistics'] == null
        ? null
        : UserStatistics.fromJson(json['statistics'] as Map),
    activities: (json['activities'] as List)
        ?.map((e) => e == null ? null : UserActivity.fromJson(e as Map))
        ?.toList(),
    attributes: json['attributes'] == null
        ? null
        : UserAttributes.fromJson(json['attributes'] as Map),
    items: (json['items'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as int),
    ),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'userId': instance.userId,
      'favorites': instance.favorites?.map((k, e) => MapEntry(k, e?.toJson())),
      'notes': instance.notes?.map((k, e) => MapEntry(k, e?.toJson())),
      'statistics': instance.statistics?.toJson(),
      'attributes': instance.attributes?.toJson(),
      'activities': instance.activities?.map((e) => e?.toJson())?.toList(),
      'items': instance.items,
    };
