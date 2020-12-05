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
    @required this.notes,
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
      notes: {
        defaultNote.id: defaultNote,
        achievedNote.id: achievedNote,
      },
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
      notes: {},
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
      notes: {
        'default': Note.dummy('ノート1', isDefaultNote: true),
        // TODO: achieved追加
      },
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

  /// オリジナルフレーズ UUIDで一発でアクセスしたい
  Map<String, Note> notes;

  List<TestResult> testResults;

  int points;

  int testLimitCount;

  String lastLogin;

  bool isIntroducedFriend;

  String age;

  String email;

  Membership membership;

  bool get isPremium => membership == Membership.pro;

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
