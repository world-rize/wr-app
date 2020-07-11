// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResponse _$TestResponseFromJson(Map json) {
  return TestResponse(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$TestResponseToJson(TestResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

ReadUserResponse _$ReadUserResponseFromJson(Map json) {
  return ReadUserResponse(
    user: json['user'] == null
        ? null
        : User.fromJson((json['user'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$ReadUserResponseToJson(ReadUserResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

CreateUserResponse _$CreateUserResponseFromJson(Map json) {
  return CreateUserResponse(
    user: json['user'] == null
        ? null
        : User.fromJson((json['user'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$CreateUserResponseToJson(CreateUserResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

FavoritePhraseResponse _$FavoritePhraseResponseFromJson(Map json) {
  return FavoritePhraseResponse(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$FavoritePhraseResponseToJson(
        FavoritePhraseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

GetPointResponse _$GetPointResponseFromJson(Map json) {
  return GetPointResponse(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$GetPointResponseToJson(GetPointResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
