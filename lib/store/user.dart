// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wr_app/model/user.dart';
import 'package:wr_app/api/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  FirebaseUser auth;

  /// レッスントップ画面に表示されるお気に入りフレーズ
  Phrase pickedUpFavoritePhrase = MasterDataStore.dummyPhrase();

  /// レッスントップ画面に表示される新着フレーズ
  Phrase pickedUpNewComingPhrase = MasterDataStore.dummyPhrase();

  /// ユーザーデータ
  User user = User();

  /// トーストを出す
  void toast(String message, {Color color = Colors.redAccent}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color,
    );
  }

  /// Firebase Auth にログイン
  Future<void> signIn() async {
    final _result = await _auth.signInAnonymously();

    auth = _result.user;

    dev.log('[UserStore#signIn] anonymous sign in ${auth.uid}');
  }

  /// ゲストユーザーかどうか
  bool _isGuest() {
    return auth.isAnonymous;
  }

  /// テストAPIを呼ぶ
  Future<void> callTestAPI() async {
    dev.log('callTestAPI');

    final data = await test().catchError((e) {
      dev.log(e.toString());
      toast(e.toString());
    });

    toast('success: ${data.success}', color: Colors.blue);

    notifyListeners();
  }

  /// ユーザーデータを習得します
  Future<void> fetchUser() async {
    dev.log('fetchUser');

    final data = await readUser().catchError((e) {
      dev.log(e.toString());
      toast(e.toString());
    });

    dev.log(data.user.uuid);
    toast('uid: ${data.user.uuid}');

    user = data.user;

    notifyListeners();
  }

  /// ユーザーを作成します
  Future<void> callCreateUser() async {
    dev.log('callCreateUser');

    final data = await createUser().catchError((e) {
      dev.log(e.toString());
      toast(e.toString());
    });

    toast(data.user.uuid, color: Colors.blue);

    user = data.user;

    notifyListeners();
  }

  /// フレーズをお気に入りに登録します
  Future<void> callFavoritePhrase(Phrase phrase) async {
    dev.log('callFavoritePhrase');

    final data = await favoritePhrase(auth.uid, phrase).catchError((e) {
      dev.log(e.toString());
    });

    dev.log(data.toString());

    notifyListeners();
  }

  /// 名前を取得
  String displayName() {
    return _isGuest() ? 'ゲスト' : auth.displayName;
  }
}
