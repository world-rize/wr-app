// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

part 'note.g.dart';

/// ノート
///
/// - 単語と訳(NotePhrase) のまとまり
/// - 単語帳は並びかえられる
@JsonSerializable(explicitToJson: true, anyMap: true)
class Note {
  Note({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required phrases,
  }) {
    _phrases = phrases;
  }

  factory Note.dummy(String title, {bool isDefault = false}) {
    final noteId = Uuid().v4();
    return Note(
      id: noteId,
      title: title,
      isDefault: isDefault,
      sortType: '',
      phrases: {},
    );
  }

  factory Note.fromJson(Map<dynamic, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  List<NotePhrase> _phrases;

  bool _checkNotePhrasesLimit() {
    return _phrases.length < 30;
  }

  Map<String, NotePhrase> get phrases {
    return _phrases;
  }

  bool addPhrase(NotePhrase phrase) {
    if (_checkNotePhrasesLimit()) {
      _phrases[phrase.id] = phrase;
      return true;
    } else {
      return false;
    }
  }
}
