// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
      uuid: json['uuid'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      name: json['name'] as String,
      point: json['point'] as int,
      favorites: (json['favorites'] as Map)?.map(
        (k, e) => MapEntry(k as String, e as bool),
      ));
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'userId': instance.userId,
      'email': instance.email,
      'age': instance.age,
      'name': instance.name,
      'point': instance.point,
      'favorites': instance.favorites
    };
