// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/note/model/note_v1.dart';

part 'note_v2.g.dart';

// ノートV2(ダミー)
@JsonSerializable(explicitToJson: true, anyMap: true)
class NoteV2 {
  NoteV2({
    @required this.id,
    @required this.titleReversed,
  });

  factory NoteV2.fromJson(Map<dynamic, dynamic> json) => _$NoteV2FromJson(json);

  factory NoteV2.fromNoteV1(NoteV1 noteV1) {
    final rev =
        String.fromCharCodes(noteV1.titleUpperCase.runes.toList().reversed);
    return NoteV2(id: noteV1.id, titleReversed: rev);
  }

  Map<String, dynamic> toJson() => _$NoteV2ToJson(this);

  String id;

  String titleReversed;
}
