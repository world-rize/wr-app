// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';

part 'favorite_phrase_list.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseList {
  FavoritePhraseList({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required this.favoritePhraseIds,
  });

  factory FavoritePhraseList.dummy() {
    return FavoritePhraseList(
      id: 'default',
      title: 'お気に入り',
      sortType: '',
      isDefault: true,
      favoritePhraseIds: {
        'debug': FavoritePhraseDigest(
          id: 'debug',
          createdAt: DateTime.now(),
        ),
      },
    );
  }

  factory FavoritePhraseList.fromJson(Map<dynamic, dynamic> json) =>
      _$FavoritePhraseListFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseListToJson(this);

  String id;

  String title;

  String sortType;

  bool isDefault;

  Map<String, FavoritePhraseDigest> favoritePhraseIds;
}
