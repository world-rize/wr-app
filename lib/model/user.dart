// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/model/activity.dart';
import 'package:wr_app/model/membership.dart';

part 'user.g.dart';

/// ユーザー
@JsonSerializable(explicitToJson: true, anyMap: true)
class User {
  User({
    @required this.uuid,
    @required this.userId,
    @required this.email,
    @required this.age,
    @required this.name,
    @required this.point,
    @required this.testLimitCount,
    @required this.favorites,
    @required this.membership,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.empty() {
    return User(
      uuid: '',
      userId: '',
      email: '',
      age: 0,
      name: '',
      point: 0,
      testLimitCount: 0,
      favorites: {},
      membership: Membership.normal,
    );
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// ユーザータイプ
  Membership membership;

  /// uuid
  String uuid;

  /// userId
  String userId;

  /// email
  String email;

  /// age
  int age;

  /// 名前
  String name;

  /// 所持ポイント
  int point;

  /// 本日のテスト可能回数
  int testLimitCount;

  /// お気に入りフレーズ
  Map<String, bool> favorites;

  /// クリア済みのセクション
  Map<String, bool> sectionStates;

  /// ユーザーログ
  List<Activity> logs;
}
