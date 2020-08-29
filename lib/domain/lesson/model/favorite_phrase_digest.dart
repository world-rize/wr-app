// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_phrase_digest.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseDigest {
  FavoritePhraseDigest({
    @required this.id,
    @required this.createdAt,
  });

  factory FavoritePhraseDigest.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseDigestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseDigestToJson(this);

  String id;

  DateTime createdAt;
}
