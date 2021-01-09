// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/note/model/note.dart';

part 'note_v1.g.dart';

// ノートV1(ダミー)
@JsonSerializable(explicitToJson: true, anyMap: true)
class NoteV1 {
  NoteV1({
    @required this.id,
    @required this.titleUpperCase,
  });

  factory NoteV1.fromJson(Map<dynamic, dynamic> json) => _$NoteV1FromJson(json);

  factory NoteV1.fromNoteV0(Note noteV0) {
    return NoteV1(id: noteV0.id, titleUpperCase: noteV0.title.toUpperCase());
  }

  Map<String, dynamic> toJson() => _$NoteV1ToJson(this);

  String id;

  String titleUpperCase;
}
