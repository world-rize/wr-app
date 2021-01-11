// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/user/model/user.dart';

part 'user_v1.g.dart';

// ユーザーV1(ダミー)
@JsonSerializable(explicitToJson: true, anyMap: true)
class UserV1 {
  UserV1({
    @required this.uuid,
    @required this.nameUpperCase,
  });

  factory UserV1.fromJson(Map<dynamic, dynamic> json) => _$UserV1FromJson(json);

  factory UserV1.fromUserV0(User userV0) {
    return UserV1(uuid: userV0.uuid, nameUpperCase: userV0.name.toUpperCase());
  }

  Map<String, dynamic> toJson() => _$UserV1ToJson(this);

  /// uuid
  String uuid;

  /// 名前
  String nameUpperCase;
}
