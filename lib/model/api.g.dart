// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResponse _$TestResponseFromJson(Map<String, dynamic> json) {
  return TestResponse(success: json['success'] as bool);
}

Map<String, dynamic> _$TestResponseToJson(TestResponse instance) =>
    <String, dynamic>{'success': instance.success};

ReadUserResponse _$ReadUserResponseFromJson(Map<String, dynamic> json) {
  return ReadUserResponse(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ReadUserResponseToJson(ReadUserResponse instance) =>
    <String, dynamic>{'user': instance.user};

CreateUserResponse _$CreateUserResponseFromJson(Map<String, dynamic> json) {
  return CreateUserResponse(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CreateUserResponseToJson(CreateUserResponse instance) =>
    <String, dynamic>{'user': instance.user};

FavoritePhraseResponse _$FavoritePhraseResponseFromJson(
    Map<String, dynamic> json) {
  return FavoritePhraseResponse(success: json['success'] as bool);
}

Map<String, dynamic> _$FavoritePhraseResponseToJson(
        FavoritePhraseResponse instance) =>
    <String, dynamic>{'success': instance.success};
