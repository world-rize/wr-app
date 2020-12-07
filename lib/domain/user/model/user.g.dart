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
    testResults: (json['testResults'] as List)
        ?.map((e) => e == null ? null : TestResult.fromJson(e as Map))
        ?.toList(),
    points: json['points'] as int,
    testLimitCount: json['testLimitCount'] as int,
    lastLogin: json['lastLogin'] as String,
    isIntroducedFriend: json['isIntroducedFriend'] as bool,
    age: json['age'] as String,
    email: json['email'] as String,
    membership: _$enumDecodeNullable(_$MembershipEnumMap, json['membership']),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'userId': instance.userId,
      'testResults': instance.testResults?.map((e) => e?.toJson())?.toList(),
      'points': instance.points,
      'testLimitCount': instance.testLimitCount,
      'lastLogin': instance.lastLogin,
      'isIntroducedFriend': instance.isIntroducedFriend,
      'age': instance.age,
      'email': instance.email,
      'membership': _$MembershipEnumMap[instance.membership],
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
