// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributes _$UserAttributesFromJson(Map json) {
  return UserAttributes(
    age: json['age'] as String,
    email: json['email'] as String,
    membership: const CustomMembershipConverter()
        .fromJson(json['membership'] as String),
  );
}

Map<String, dynamic> _$UserAttributesToJson(UserAttributes instance) =>
    <String, dynamic>{
      'age': instance.age,
      'email': instance.email,
      'membership':
          const CustomMembershipConverter().toJson(instance.membership),
    };
