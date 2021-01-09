// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserV1 _$UserV1FromJson(Map json) {
  return UserV1(
    uuid: json['uuid'] as String,
    nameUpperCase: json['nameUpperCase'] as String,
  );
}

Map<String, dynamic> _$UserV1ToJson(UserV1 instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'nameUpperCase': instance.nameUpperCase,
    };
