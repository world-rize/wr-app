// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/system/model/user_activity.dart';
import 'package:wr_app/domain/user/model/membership.dart';

part 'user.g.dart';

/// 統計情報
@JsonSerializable(explicitToJson: true, anyMap: true)
class UserStatistics {
  UserStatistics({
    @required this.testScores,
    @required this.points,
    @required this.testLimitCount,
  });

  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatisticsToJson(this);

  Map<String, String> testScores;

  int points;

  int testLimitCount;
}

/// ユーザー情報
@JsonSerializable(explicitToJson: true, anyMap: true)
class UserAttributes {
  UserAttributes({
    this.age,
    this.email,
    this.membership,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);

  String age;

  String email;

  Membership membership;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseDigest {
  FavoritePhraseDigest({
    @required this.id,
    @required this.createdAt,
  });

  factory FavoritePhraseDigest.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseDigestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseDigestToJson(this);

  String id;

  DateTime createdAt;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseList {
  FavoritePhraseList({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required this.favoritePhraseIds,
  });

  factory FavoritePhraseList.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseListFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseListToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  Map<String, FavoritePhraseDigest> favoritePhraseIds;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class PhraseList {
  PhraseList({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required this.phrases,
  });

  factory PhraseList.fromJson(Map<String, dynamic> json) =>
      _$PhraseListFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseListToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  Map<String, Phrase> phrases;
}

/// ユーザー
@JsonSerializable(explicitToJson: true, anyMap: true)
class User {
  User({
    @required this.uuid,
    @required this.name,
    @required this.userId,
    @required this.favorites,
    @required this.notes,
    @required this.statistics,
    @required this.activities,
    @required this.attributes,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.empty() {
    return User(
      uuid: '',
      name: '',
      userId: '',
      favorites: {
        'default': FavoritePhraseList(
          id: 'default',
          title: 'お気に入り',
          sortType: '',
          isDefault: true,
          favoritePhraseIds: {},
        ),
      },
      statistics: UserStatistics(
        testScores: {},
        points: 0,
        testLimitCount: 0,
      ),
      attributes: UserAttributes(
        age: '0',
        email: 'hoge@example.com',
        membership: Membership.normal,
      ),
      activities: [],
      notes: {},
    );
  }

  factory User.dummy() {
    return User(
      uuid: 'uuid',
      name: 'Dummy',
      userId: '123-456-789',
      favorites: {
        'default': FavoritePhraseList(
          id: 'default',
          title: 'お気に入り',
          sortType: '',
          isDefault: true,
          favoritePhraseIds: {
            'debug': FavoritePhraseDigest(
              id: 'debug',
              createdAt: DateTime.now(),
            ),
          },
        ),
      },
      statistics: UserStatistics(
        testScores: {
          'debug': '5',
        },
        points: 100,
        testLimitCount: 3,
      ),
      attributes: UserAttributes(
        age: '0',
        email: 'hoge@example.com',
        membership: Membership.normal,
      ),
      activities: [
        UserActivity(
          content: 'Dummy Activity',
          date: DateTime.now(),
        ),
      ],
      notes: {},
    );
  }

  /// uuid
  String uuid;

  /// 名前
  String name;

  /// userId
  String userId;

  /// お気に入りフレーズ
  Map<String, FavoritePhraseList> favorites;

  /// オリジナルフレーズ
  Map<String, PhraseList> notes;

  /// 統計情報
  UserStatistics statistics;

  /// 個人情報
  UserAttributes attributes;

  /// ユーザー活動
  List<UserActivity> activities;

  bool get isPremium => attributes.membership == Membership.pro;

  ///
  bool isFavoritePhrase(String phraseId) {
    return favorites['default'].favoritePhraseIds.containsKey(phraseId);
  }
}
