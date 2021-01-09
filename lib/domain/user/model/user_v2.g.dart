// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserV2 _$UserV2FromJson(Map json) {
  return UserV2(
    uuid: json['uuid'] as String,
    nameReversed: json['nameReversed'] as String,
  );
}

Map<String, dynamic> _$UserV2ToJson(UserV2 instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'nameReversed': instance.nameReversed,
    };
