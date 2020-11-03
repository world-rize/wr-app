// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'note_phrase.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class NotePhrase {
  NotePhrase({
    required this.id,
    required this.english,
    required this.japanese,
    required this.createdAt,
  });

  factory NotePhrase.dummy({required String id}) {
    return NotePhrase(
      id: id,
      japanese: 'こんにちは',
      english: 'Hello',
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  /// wordとtranslationからNotePhraseを新しく作る
  factory NotePhrase.create({String english = '', String japanese = ''}) {
    final uuid = Uuid().v4();
    return NotePhrase(
      id: uuid,
      english: english,
      japanese: japanese,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  /// uuid
  String id;

  /// 単語
  String english;

  /// 訳
  String japanese;

  /// 作成日時
  //  TODO: DateTimeに
  String createdAt;

  factory NotePhrase.fromJson(Map<String, dynamic> json) =>
      _$NotePhraseFromJson(json);

  Map<String, dynamic> toJson() => _$NotePhraseToJson(this);
}
