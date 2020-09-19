// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';

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
    @required this.isDefaultNote,
    @required this.isAchievedNote,
    @required List<NotePhrase> phrases,
  }) {
    _phrases = phrases;
  }

  factory Note.dummy(
    String title, {
    bool isDefaultNote = false,
    bool isAchievedNote = false,
  }) {
    final noteId = Uuid().v4();
    return Note(
      id: noteId,
      title: title,
      isDefaultNote: isDefaultNote,
      isAchievedNote: isAchievedNote,
      sortType: '',
      phrases: List<NotePhrase>.generate(30, (_) => NotePhrase.create()),
    );
  }

  factory Note.empty(
    String title, {
    bool isDefaultNote = false,
    bool isAchievedNote = false,
  }) {
    final noteId = Uuid().v4();
    return Note(
      id: noteId,
      title: title,
      isDefaultNote: isDefaultNote,
      isAchievedNote: isAchievedNote,
      sortType: '',
      phrases: List<NotePhrase>.generate(30, (_) => NotePhrase.create()),
    );
  }

  factory Note.fromJson(Map<dynamic, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefaultNote, isAchievedNote;

  List<NotePhrase> _phrases;

  List<NotePhrase> get phrases => _phrases;

  Note clone() {
    final jsonString = json.encode(this);
    final jsonResponse = json.decode(jsonString);
    return Note.fromJson(jsonResponse as Map<String, dynamic>);
  }

  /// achieved noteなら何個でもしまえる
  /// そうでないならfalse
  bool addPhrase(NotePhrase phrase) {
    if (isAchievedNote) {
      _phrases.add(phrase);
      return true;
    } else {
      return false;
    }
  }

  /// ないならnullを返す
  NotePhrase findByNotePhraseId(String id) {
    return _phrases.firstWhere(
      (element) => element.id == id,
      orElse: () => null,
    );
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

  /// 空のノートフレーズを返す、ないならnullを返す
  NotePhrase firstEmptyNotePhrase() {
    return _phrases.firstWhere(
      (element) => element.japanese == '' && element.english == '',
      orElse: () => null,
    );
  }
}
