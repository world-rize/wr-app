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
    testLimitCount: json['testLimitCount'] as int,
    favorites: (json['favorites'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as bool),
    ),
    membership: _$enumDecodeNullable(_$MembershipEnumMap, json['membership']),
  )
    ..sectionStates = (json['sectionStates'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as bool),
    )
    ..logs = (json['logs'] as List)
        ?.map((e) => e == null
            ? null
            : Activity.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'membership': _$MembershipEnumMap[instance.membership],
      'uuid': instance.uuid,
      'userId': instance.userId,
      'email': instance.email,
      'age': instance.age,
      'name': instance.name,
      'point': instance.point,
      'testLimitCount': instance.testLimitCount,
      'favorites': instance.favorites,
      'sectionStates': instance.sectionStates,
      'logs': instance.logs?.map((e) => e?.toJson())?.toList(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MembershipEnumMap = {
  Membership.normal: 'normal',
  Membership.pro: 'pro',
};
