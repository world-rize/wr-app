// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/index.dart';

part 'note_phrase.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class NotePhrase {
  NotePhrase({
    @required this.id,
    @required this.word,
    @required this.translation,
    @required this.achieved,
  });

  factory NotePhrase.dummy({@required String id}) {
    return NotePhrase(id: id, word: id, translation: id, achieved: false);
  }

  factory NotePhrase.fromPhrase(Phrase phrase) {
    return NotePhrase(
      id: phrase.id,
      word: phrase.title['en'],
      translation: phrase.title['ja'],
      achieved: false,
    );
  }

  /// uuid
  String id;

  /// 単語
  String word;

  /// 訳
  String translation;

  /// achieved
  bool achieved;

  factory NotePhrase.fromJson(Map<String, dynamic> json) =>
      _$NotePhraseFromJson(json);

  Map<String, dynamic> toJson() => _$NotePhraseToJson(this);
}
