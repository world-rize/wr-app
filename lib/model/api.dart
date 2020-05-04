// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/model/user.dart';

part 'api.g.dart';

// see https://stackoverflow.com/questions/58741971/casterror-type-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-of
@JsonSerializable(explicitToJson: true, anyMap: true)
class TestResponse {
  TestResponse({this.success});

  factory TestResponse.fromJson(Map<String, dynamic> json) =>
      _$TestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestResponseToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ReadUserResponse {
  ReadUserResponse({this.user});

  factory ReadUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ReadUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadUserResponseToJson(this);

  User user;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateUserResponse {
  CreateUserResponse({this.user});

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserResponseToJson(this);

  User user;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseResponse {
  FavoritePhraseResponse({this.success});

  factory FavoritePhraseResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseResponseToJson(this);

  bool success;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class GetPointResponse {
  GetPointResponse({this.success});

  factory GetPointResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPointResponseToJson(this);

  bool success;
}
