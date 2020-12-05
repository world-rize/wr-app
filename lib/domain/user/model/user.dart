// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/system/model/user_activity.dart';
import 'package:wr_app/domain/user/model/membership.dart';

part 'user.g.dart';

/// ユーザー
@JsonSerializable(explicitToJson: true, anyMap: true)
class User {
  User({
    @required this.uuid,
    @required this.name,
    @required this.userId,
    @required this.testResults,
    @required this.points,
    @required this.testLimitCount,
    @required this.lastLogin,
    @required this.isIntroducedFriend,
    @required this.age,
    @required this.email,
    @required this.membership,
  });

  factory User.create() {
    final uuid = Uuid().v4();

    return User(
      uuid: uuid,
      name: '',
      // TODO
      userId: uuid,
      testResults: [],
      points: 0,
      testLimitCount: 3,
      lastLogin: DateTime.now().toIso8601String(),
      isIntroducedFriend: false,
      age: '',
      email: '',
      membership: Membership.normal,
    );
  }

  factory User.empty() {
    return User(
      uuid: '',
      name: '',
      userId: '',
      testResults: [],
      points: 0,
      testLimitCount: 0,
      lastLogin: '',
      isIntroducedFriend: false,
      age: '0',
      email: 'hoge@example.com',
      membership: Membership.normal,
    );
  }

  factory User.dummy() {
    return User(
      uuid: 'uuid',
      name: 'Dummy',
      userId: '123-456-789',
      testResults: <TestResult>[],
      points: 100,
      testLimitCount: 3,
      lastLogin: '',
      isIntroducedFriend: false,
      age: '0',
      email: 'hoge@example.com',
      membership: Membership.normal,
    );
  }

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// uuid
  String uuid;

  /// 名前
  String name;

  /// userId
  String userId;

  List<TestResult> testResults;

  int points;

  int testLimitCount;

  String lastLogin;

  bool isIntroducedFriend;

  String age;

  String email;

  Membership membership;

  bool get isPremium => membership == Membership.pro;
}
