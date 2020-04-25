// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/model/user.dart';

part 'api.g.dart';

@JsonSerializable()
class TestResponse {
  TestResponse({this.success});

  bool success;

  factory TestResponse.fromJson(Map<String, dynamic> json) =>
      _$TestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestResponseToJson(this);
}

@JsonSerializable()
class ReadUserResponse {
  ReadUserResponse({this.user});

  factory ReadUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ReadUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadUserResponseToJson(this);

  User user;
}

@JsonSerializable()
class CreateUserResponse {
  CreateUserResponse({this.user});

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserResponseToJson(this);

  User user;
}

@JsonSerializable()
class FavoritePhraseResponse {
  FavoritePhraseResponse({this.success});

  factory FavoritePhraseResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseResponseToJson(this);

  bool success;
}
