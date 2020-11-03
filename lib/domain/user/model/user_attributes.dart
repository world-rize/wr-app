// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/util/membership_convertor.dart';

part 'user_attributes.g.dart';

/// ユーザー情報
@JsonSerializable(explicitToJson: true, anyMap: true)
@CustomMembershipConverter()
class UserAttributes {
  UserAttributes({
    required this.age,
    required this.email,
    required this.membership,
  });

  factory UserAttributes.dummy() {
    return UserAttributes(
      age: '0',
      email: 'hoge@example.com',
      membership: Membership.normal,
    );
  }

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);

  String age;

  String email;

  Membership membership;
}
