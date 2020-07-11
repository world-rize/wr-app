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
  return CreateUserRequestDto();
}

Map<String, dynamic> _$CreateUserRequestDtoToJson(
        CreateUserRequestDto instance) =>
    <String, dynamic>{};

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
    point: json['point'] as int,
  );
}

Map<String, dynamic> _$GetPointRequestDtoToJson(GetPointRequestDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'point': instance.point,
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
    sectionId: json['sectionId'] as String,
  );
}

Map<String, dynamic> _$DoTestRequestDtoToJson(DoTestRequestDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'sectionId': instance.sectionId,
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
