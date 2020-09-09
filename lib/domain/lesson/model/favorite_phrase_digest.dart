// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_phrase_digest.g.dart';

/// 「お気に入り」の情報
@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseDigest {
  FavoritePhraseDigest({
    @required this.id,
    @required this.createdAt,
  });

  factory FavoritePhraseDigest.fromJson(Map<dynamic, dynamic> json) =>
      _$FavoritePhraseDigestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseDigestToJson(this);

  /// フレーズID
  String id;

  /// 実行日時
  DateTime createdAt;
}
