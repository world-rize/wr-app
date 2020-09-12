// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
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
    @required this.phrases,
  });

  /// ダミーを作成
  factory FavoritePhraseList.dummy() {
    return FavoritePhraseList(
      id: 'default',
      title: 'お気に入り',
      sortType: '',
      isDefault: true,
      phrases: [
        FavoritePhraseDigest(
          id: 'debug',
          createdAt: DateTime.now(),
        ),
      ],
    );
  }

  /// 空の作成
  factory FavoritePhraseList.empty(String title) {
    final id = Uuid().v4();
    return FavoritePhraseList(
      id: id,
      title: title,
      sortType: '',
      isDefault: false,
      phrases: [],
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
  List<FavoritePhraseDigest> phrases;

  void addPhrase(FavoritePhraseDigest phrase) {
    phrases.add(phrase);
  }

  FavoritePhraseDigest findByPhraseId(String id) {
    return phrases.firstWhere((element) => element.id == id, orElse: null);
  }

  bool updatePhrase(String id, FavoritePhraseDigest digest) {
    final index = phrases.indexWhere((element) => element.id == id);
    if (index != -1) {
      phrases[index] = digest;
      return true;
    } else {
      return false;
    }
  }

  bool deletePhrase(String id) {
    final index = phrases.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      phrases.removeAt(index);
      return true;
    } else {
      return false;
    }
  }
}
