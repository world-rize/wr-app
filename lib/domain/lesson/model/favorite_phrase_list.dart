// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';

part 'favorite_phrase_list.g.dart';

/// 「お気に入り」のリスト
///
/// - ユーザーはお気に入りリスト一つ以上持ち
/// - 必ずデフォルトのお気に入りリストをもつ
/// - お気に入りリストに名前を付けられる
/// - ハートアイコンを押下するとデフォルトのお気に入りリストに追加される
/// - お気に入りリストのフレーズは並び替え可能
///
@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseList {
  FavoritePhraseList({
    @required this.id,
    @required this.title,
    @required this.sortType,
    @required this.isDefault,
    @required this.favoritePhraseIds,
  });

  /// ダミーを作成
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

  /// ID
  String id;

  /// タイトル
  String title;

  /// ソート
  // TODO: 未実装
  String sortType;

  /// デフォルトか
  bool isDefault;

  /// フレーズ
  // TODO: 並び替えができるようにリストで保持
  Map<String, FavoritePhraseDigest> favoritePhraseIds;
}
