// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/user/model/user.dart';

part 'user_api_dto.g.dart';

// XXXRequestDto
// XXXResponseDto

// because of adding `@JsonSerializable(explicitToJson: true, anyMap: true)`
// see https://stackoverflow.com/questions/58741971/casterror-type-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-of

@JsonSerializable(explicitToJson: true, anyMap: true)
class TestRequestDto {
  factory TestRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TestRequestDtoFromJson(json);

  TestRequestDto() {}

  Map<String, dynamic> toJson() => _$TestRequestDtoToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class TestResponse {
  TestResponse({
    @required this.success,
  });

  factory TestResponse.fromJson(Map<String, dynamic> json) =>
      _$TestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestResponseToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ReadUserRequestDto {
  factory ReadUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReadUserRequestDtoFromJson(json);

  ReadUserRequestDto() {}

  Map<String, dynamic> toJson() => _$ReadUserRequestDtoToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ReadUserResponseDto {
  ReadUserResponseDto({
    @required this.user,
  });

  factory ReadUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReadUserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReadUserResponseDtoToJson(this);

  User user;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateUserRequestDto {
  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDtoFromJson(json);

  CreateUserRequestDto() {}

  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateUserResponseDto {
  CreateUserResponseDto({
    @required this.user,
  });

  factory CreateUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserResponseDtoToJson(this);

  User user;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateUserRequestDto {
  UpdateUserRequestDto({
    @required this.user,
  });

  factory UpdateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestDtoToJson(this);

  User user;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateUserResponseDto {
  UpdateUserResponseDto({
    @required this.success,
  });

  factory UpdateUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserResponseDtoToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeleteUserRequestDto {
  DeleteUserRequestDto({
    @required this.user,
  });

  factory DeleteUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserRequestDtoToJson(this);

  User user;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeleteUserResponseDto {
  DeleteUserResponseDto({
    @required this.success,
  });

  factory DeleteUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserResponseDtoToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseRequestDto {
  FavoritePhraseRequestDto({
    @required this.uid,
    @required this.phraseId,
    @required this.value,
  });

  factory FavoritePhraseRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseRequestDtoToJson(this);

  String uid;
  String phraseId;
  bool value;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseResponseDto {
  FavoritePhraseResponseDto({
    @required this.success,
  });

  factory FavoritePhraseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseResponseDtoToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class GetPointRequestDto {
  GetPointRequestDto({
    @required this.uid,
    @required this.point,
  });

  factory GetPointRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetPointRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetPointRequestDtoToJson(this);

  String uid;
  int point;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class GetPointResponseDto {
  GetPointResponseDto({
    @required this.success,
  });

  factory GetPointResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetPointResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetPointResponseDtoToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DoTestRequestDto {
  DoTestRequestDto({
    @required this.uid,
  });

  factory DoTestRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DoTestRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DoTestRequestDtoToJson(this);

  String uid;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DoTestResponseDto {
  DoTestResponseDto({
    @required this.success,
  });

  factory DoTestResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DoTestResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DoTestResponseDtoToJson(this);

  bool success;
}
