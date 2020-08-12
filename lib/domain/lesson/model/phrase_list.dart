// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/lesson/index.dart';

part 'phrase_list.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class PhraseList {
  PhraseList({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required this.phrases,
  });

  factory PhraseList.dummy(String title, String listId,
      {bool isDefault = false}) {
    final phrases = List.generate(10, (index) => Phrase.note(Uuid().v4()));
    return PhraseList(
      id: listId,
      title: title,
      isDefault: isDefault,
      sortType: '',
      phrases: Map<String, Phrase>.fromIterable(phrases, key: (p) => p.id),
    );
  }

  factory PhraseList.fromJson(Map<String, dynamic> json) =>
      _$PhraseListFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseListToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  Map<String, Phrase> phrases;
}
