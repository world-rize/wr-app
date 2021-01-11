// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/user/model/user_v1.dart';

part 'user_v2.g.dart';

// ユーザーV2(ダミー)
@JsonSerializable(explicitToJson: true, anyMap: true)
class UserV2 {
  UserV2({
    @required this.uuid,
    @required this.nameReversed,
  });

  factory UserV2.fromJson(Map<dynamic, dynamic> json) => _$UserV2FromJson(json);

  factory UserV2.fromUserV1(UserV1 userV1) {
    final rev =
        String.fromCharCodes(userV1.nameUpperCase.runes.toList().reversed);
    return UserV2(uuid: userV1.uuid, nameReversed: rev);
  }

  Map<String, dynamic> toJson() => _$UserV2ToJson(this);

  /// uuid
  String uuid;

  /// 名前
  String nameReversed;
}
