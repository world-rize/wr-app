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
    @required List<NotePhrase> phrases,
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
      phrases: [],
    );
  }

  factory Note.empty(String title, {bool isDefault = false}) {
    final noteId = Uuid().v4();
    return Note(
      id: noteId,
      title: title,
      isDefault: isDefault,
      sortType: '',
      phrases: List<NotePhrase>.filled(30, NotePhrase.create('', '')),
    );
  }

  factory Note.fromJson(Map<dynamic, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  List<NotePhrase> _phrases;

  List<NotePhrase> get phrases => [..._phrases];

  bool _belowNotePhrasesLimit() {
    return _phrases.length < 30;
  }

  bool addPhrase(NotePhrase phrase) {
    if (_belowNotePhrasesLimit()) {
      _phrases.add(phrase);
      return true;
    } else {
      return false;
    }
  }

  NotePhrase findByNotePhraseId(String id) {
    return _phrases.firstWhere((element) => element.id == id, orElse: null);
  }

  bool updateNotePhrase(String id, NotePhrase phrase) {
    final index = _phrases.indexWhere((element) => element.id == id);
    if (index != -1) {
      _phrases[index] = phrase;
      return true;
    } else {
      return false;
    }
  }

  bool deleteNotePhrase(String id) {
    final index = _phrases.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      _phrases.removeAt(index);
      return true;
    } else {
      return false;
    }
  }
}
