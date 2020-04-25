// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  /// 成功トーストを出す
  void successToast(String message) {
    dev.log(message);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
    );
  }

  /// エラートーストを出す
  void errorToast(Exception e) {
    dev.log(e.toString(), level: 1);
    Fluttertoast.showToast(
      msg: 'エラーが発生',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }

  /// Firebase Auth にログイン
  Future<void> signIn() async {
    final _result = await _auth.signInAnonymously();

    auth = _result.user;

    successToast('ログインしました');

    dev.log('[UserStore#signIn] anonymous sign in ${auth.uid}');
  }

  /// ゲストユーザーかどうか
  bool _isGuest() {
    return auth.isAnonymous;
  }

  /// テストAPIを呼ぶ
  Future<void> callTestAPI() async {
    dev.log('callTestAPI');

    try {
      final data = await test();

      successToast('成功');

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// ユーザーデータを習得します
  Future<void> fetchUser() async {
    dev.log('fetchUser');

    try {
      final data = await readUser();

      dev.log(data.user.uuid);

      successToast('uid: ${data.user.uuid}');

      user = data.user;

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// ユーザーを作成します
  Future<void> callCreateUser() async {
    dev.log('callCreateUser');

    try {
      final data = await createUser();

      user = data.user;

      successToast('ユーザーを作成しました');

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// フレーズをお気に入りに登録します
  Future<void> callFavoritePhrase(
      {@required String phraseId, @required bool value}) async {
    dev.log('callFavoritePhrase');

    try {
      final data =
          await favoritePhrase(uid: auth.uid, phraseId: phraseId, value: value);

      dev.log(data.toString());

      successToast('お気に入りに登録しました');

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// 名前を取得
  String displayName() {
    return _isGuest() ? 'ゲスト' : auth.displayName;
  }
}
