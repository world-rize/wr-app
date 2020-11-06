// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/system/model/user_activity.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user_attributes.dart';
import 'package:wr_app/domain/user/model/user_statistics.dart';

part 'user.g.dart';

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
    @required this.items,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.create() {
    final uuid = Uuid().v4();
    final defaultFavoriteList = FavoritePhraseList.create(
      title: 'お気に入り',
      isDefault: true,
    );
    final defaultNote = Note.create(
      title: 'ノート',
      isDefault: true,
    );
    final achievedNote = Note.create(
      title: 'Achieved Note',
      isAchieved: true,
    );

    return User(
      uuid: uuid,
      name: '',
      // TODO
      userId: uuid,
      favorites: {
        defaultFavoriteList.id: defaultFavoriteList,
      },
      notes: {
        defaultNote.id: defaultNote,
        achievedNote.id: achievedNote,
      },
      statistics: UserStatistics(
        testResults: [],
        points: 0,
        testLimitCount: 3,
        lastLogin: DateTime.now().toIso8601String(),
        isIntroducedFriend: false,
      ),
      activities: [],
      attributes: UserAttributes(
        age: '',
        email: '',
        membership: Membership.normal,
      ),
      items: {},
    );
  }

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
          phrases: [],
        ),
      },
      statistics: UserStatistics(
        testResults: [],
        points: 0,
        testLimitCount: 0,
        lastLogin: '',
        isIntroducedFriend: false,
      ),
      attributes: UserAttributes(
        age: '0',
        email: 'hoge@example.com',
        membership: Membership.normal,
      ),
      activities: [],
      notes: {},
      items: {},
    );
  }

  factory User.dummy() {
    return User(
      uuid: 'uuid',
      name: 'Dummy',
      userId: '123-456-789',
      favorites: {
        'default': FavoritePhraseList.dummy(),
      },
      statistics: UserStatistics.dummy(),
      attributes: UserAttributes.dummy(),
      activities: [
        UserActivity(
          content: 'Dummy Activity',
          date: DateTime.now(),
        ),
      ],
      notes: {
        'default': Note.dummy('ノート1', isDefaultNote: true),
        // TODO: achieved追加
      },
      items: {
        '3': 1,
        '4': 1,
      },
    );
  }

  /// uuid
  String uuid;

  /// 名前
  String name;

  /// userId
  String userId;

  /// お気に入りフレーズのリストのマップ
  Map<String, FavoritePhraseList> favorites;

  /// オリジナルフレーズ UUIDで一発でアクセスしたい
  Map<String, Note> notes;

  /// 統計情報
  UserStatistics statistics;

  /// 個人情報
  UserAttributes attributes;

  /// ユーザー活動
  List<UserActivity> activities;

  /// 所持アイテム(key: item_id, value: amount)
  Map<String, int> items;

  bool get isPremium => attributes.membership == Membership.pro;

  FavoritePhraseList getDefaultFavoriteList() {
    return favorites.values
        .firstWhere((list) => list.isDefault, orElse: () => null);
  }

  Note getNoteById({String noteId}) {
    // ノートを削除した直後はnullになる
    if (noteId == null || noteId.isEmpty) {
      return getDefaultNote();
    }
    return notes.values
        .firstWhere((note) => note.id == noteId, orElse: () => null);
  }

  Note getDefaultNote() {
    return notes.values
        .firstWhere((note) => note.isDefaultNote, orElse: () => null);
  }

  Note getAchievedNote() {
    return notes.values
        .firstWhere((note) => note.isAchievedNote, orElse: () => null);
  }

  NotePhrase getPhrase({@required String noteId, @required String phraseId}) {
    return getNoteById(noteId: noteId)?.findByNotePhraseId(phraseId);
  }
}
