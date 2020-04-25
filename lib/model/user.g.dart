// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      point: json['point'] as int,
      favorites: (json['favorites'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as bool),
      ));
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'point': instance.point,
      'favorites': instance.favorites
    };
