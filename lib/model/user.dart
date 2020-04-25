// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// ユーザー
@JsonSerializable()
class User {
  User({this.uuid, this.name, this.point, this.favorites});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// uuid
  String uuid;

  /// 名前
  String name;

  /// 所持ポイント
  int point;

  /// お気に入りフレーズ
  Map<String, bool> favorites;
}
