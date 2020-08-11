// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributes _$UserAttributesFromJson(Map json) {
  return UserAttributes(
    age: json['age'] as String,
    email: json['email'] as String,
    membership: _$enumDecodeNullable(_$MembershipEnumMap, json['membership']),
  );
}

Map<String, dynamic> _$UserAttributesToJson(UserAttributes instance) =>
    <String, dynamic>{
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
