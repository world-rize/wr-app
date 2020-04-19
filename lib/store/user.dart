// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

/// FireStore Auth
final FirebaseAuth _auth = FirebaseAuth.instance;

/// ユーザーデータストア
class UserStore with ChangeNotifier {
  factory UserStore() {
    return _cache;
  }

  UserStore._internal();

  /// シングルトンインスタンス
  static final UserStore _cache = UserStore._internal();

  /// Firebase User
  FirebaseUser _user;

  /// レッスントップ画面に表示されるお気に入りフレーズ
  Phrase pickedUpFavoritePhrase = MasterDataStore.dummyPhrase();

  /// レッスントップ画面に表示される新着フレーズ
  Phrase pickedUpNewComingPhrase = MasterDataStore.dummyPhrase();

  /// ポイント
  int point = 0;

  /// Firebase Auth にログイン
  Future<void> signIn() async {
    final _result = await _auth.signInAnonymously();

    dev.log('[UserStore#signIn] anonymous sign in');

    _user = _result.user;

    await callTestApi();
  }

  /// ゲストユーザーかどうか
  bool _isGuest() {
    return _user.isAnonymous;
  }

  Future<void> callTestApi() async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'test')
          ..timeout = const Duration(seconds: 10);

    try {
      final result = await callable.call({
        'hoge': 'aaa',
      });

      print(result.data);
    } on CloudFunctionsException catch (e) {
      print(e);
    }
  }

  Future<void> callCreateUserApi() async {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createUser')
          ..timeout = const Duration(seconds: 10);

    try {
      final result = await callable.call({});

      print(result.data);
    } on CloudFunctionsException catch (e) {
      print(e);
    }
  }

  /// 名前を取得
  String displayName() {
    return _isGuest() ? 'ゲスト' : _user.displayName;
  }
}
