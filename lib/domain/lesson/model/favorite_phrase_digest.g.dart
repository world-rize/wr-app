// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_phrase_digest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePhraseDigest _$FavoritePhraseDigestFromJson(Map json) {
  return FavoritePhraseDigest(
    id: json['id'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$FavoritePhraseDigestToJson(
        FavoritePhraseDigest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
