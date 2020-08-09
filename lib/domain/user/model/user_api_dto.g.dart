// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestRequestDto _$TestRequestDtoFromJson(Map json) {
  return TestRequestDto();
}

Map<String, dynamic> _$TestRequestDtoToJson(TestRequestDto instance) =>
    <String, dynamic>{};

TestResponse _$TestResponseFromJson(Map json) {
  return TestResponse(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$TestResponseToJson(TestResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

ReadUserRequestDto _$ReadUserRequestDtoFromJson(Map json) {
  return ReadUserRequestDto();
}

Map<String, dynamic> _$ReadUserRequestDtoToJson(ReadUserRequestDto instance) =>
    <String, dynamic>{};

ReadUserResponseDto _$ReadUserResponseDtoFromJson(Map json) {
  return ReadUserResponseDto(
    user: json['user'] == null
        ? null
        : User.fromJson((json['user'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$ReadUserResponseDtoToJson(
        ReadUserResponseDto instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

CreateUserRequestDto _$CreateUserRequestDtoFromJson(Map json) {
  return CreateUserRequestDto(
    name: json['name'] as String,
    email: json['email'] as String,
    age: json['age'] as String,
  );
}

Map<String, dynamic> _$CreateUserRequestDtoToJson(
        CreateUserRequestDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
    };

CreateUserResponseDto _$CreateUserResponseDtoFromJson(Map json) {
  return CreateUserResponseDto(
    user: json['user'] == null
        ? null
        : User.fromJson((json['user'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$CreateUserResponseDtoToJson(
        CreateUserResponseDto instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

UpdateUserRequestDto _$UpdateUserRequestDtoFromJson(Map json) {
  return UpdateUserRequestDto(
    user: json['user'] == null
        ? null
        : User.fromJson((json['user'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$UpdateUserRequestDtoToJson(
        UpdateUserRequestDto instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

UpdateUserResponseDto _$UpdateUserResponseDtoFromJson(Map json) {
  return UpdateUserResponseDto(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$UpdateUserResponseDtoToJson(
        UpdateUserResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

DeleteUserRequestDto _$DeleteUserRequestDtoFromJson(Map json) {
  return DeleteUserRequestDto(
    user: json['user'] == null
        ? null
        : User.fromJson((json['user'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$DeleteUserRequestDtoToJson(
        DeleteUserRequestDto instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

DeleteUserResponseDto _$DeleteUserResponseDtoFromJson(Map json) {
  return DeleteUserResponseDto(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$DeleteUserResponseDtoToJson(
        DeleteUserResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

FavoritePhraseRequestDto _$FavoritePhraseRequestDtoFromJson(Map json) {
  return FavoritePhraseRequestDto(
    uid: json['uid'] as String,
    phraseId: json['phraseId'] as String,
    value: json['value'] as bool,
  );
}

Map<String, dynamic> _$FavoritePhraseRequestDtoToJson(
        FavoritePhraseRequestDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'phraseId': instance.phraseId,
      'value': instance.value,
    };

FavoritePhraseResponseDto _$FavoritePhraseResponseDtoFromJson(Map json) {
  return FavoritePhraseResponseDto(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$FavoritePhraseResponseDtoToJson(
        FavoritePhraseResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

GetPointRequestDto _$GetPointRequestDtoFromJson(Map json) {
  return GetPointRequestDto(
    uid: json['uid'] as String,
    points: json['points'] as int,
  );
}

Map<String, dynamic> _$GetPointRequestDtoToJson(GetPointRequestDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'points': instance.points,
    };

GetPointResponseDto _$GetPointResponseDtoFromJson(Map json) {
  return GetPointResponseDto(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$GetPointResponseDtoToJson(
        GetPointResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

DoTestRequestDto _$DoTestRequestDtoFromJson(Map json) {
  return DoTestRequestDto(
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$DoTestRequestDtoToJson(DoTestRequestDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
    };

DoTestResponseDto _$DoTestResponseDtoFromJson(Map json) {
  return DoTestResponseDto(
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$DoTestResponseDtoToJson(DoTestResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
