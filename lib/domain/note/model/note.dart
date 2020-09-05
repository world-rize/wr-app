// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

part 'note.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Note {
  Note({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required this.phrases,
  });

  factory Note.dummy(String title, {bool isDefault = false}) {
    final phrases =
        List.generate(10, (index) => NotePhrase.dummy(id: Uuid().v4()));
    return Note(
      id: Uuid().v4(),
      title: title,
      isDefault: isDefault,
      sortType: '',
      phrases: Map<String, NotePhrase>.fromIterable(phrases, key: (p) => p.id),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  Map<String, NotePhrase> phrases;
}
