// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/api/mock.dart';
import 'package:wr_app/model/phrase.dart';
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

  UserStore._internal() {
    dev.log('✨ UserStore._internal()');
  }

  /// シングルトンインスタンス
  static final UserStore _cache = UserStore._internal();

  /// Firebase User
  FirebaseUser auth;

  /// レッスントップ画面に表示されるお気に入りフレーズ
  Phrase pickedUpFavoritePhrase = dummyPhrase();

  /// レッスントップ画面に表示される新着フレーズ
  Phrase pickedUpNewComingPhrase = dummyPhrase();

  /// ユーザーデータ
  User user = User(
      name: '',
      point: 0,
      age: 0,
      email: '',
      favorites: {},
      userId: '',
      uuid: '');

  /// 成功トーストを出す
  void successToast(String message) {
    dev.log('\t ✔ $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
    );
  }

  /// エラートーストを出す
  void errorToast(Exception e) {
    dev.log('\t⚠ $e', level: 1);
    Fluttertoast.showToast(
      msg: 'エラーが発生',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }

  /// ユーザーデータを習得します
  Future<User> callReadUser() async {
    dev.log('callReadUser()');

    try {
      final res = await readUser();
      return res.user;
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// Firebase Auth にサインインしユーザーデータを取得する
  Future<void> signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      auth = await _signInAuth(email: email, password: password);

      dev.log('\t ✔ user sign in ${auth.uid}');

      user = await callReadUser();

      dev.log('\t ✔ user fetched ${user.name}');

      successToast('ログインしました');

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// Firebase Auth にログイン
  Future<FirebaseUser> _signInAuth({
    @required String email,
    @required String password,
  }) async {
    try {
      final _result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // final _result = await _auth.signInAnonymously();

      return _result.user;
    } on Exception catch (e) {
      errorToast(e);
    }
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

  /// ユーザーを作成します
  Future<void> callCreateUser() async {
    dev.log('\tcallCreateUser()');

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
      {@required String phraseId, @required bool value}) {
    dev.log('\tcallFavoritePhrase()');

    try {
      favoritePhrase(uid: auth.uid, phraseId: phraseId, value: value)
          .then((res) {
        successToast(value ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
      });

      user.favorites[phraseId] = value;

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int point}) async {
    dev.log('\tcallGetPoint()');

    try {
      final data = await getPoint(uid: auth.uid, point: point);

      dev.log(data.toString());

      successToast('$pointポイントゲットしました');

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// 名前を取得
  String displayName() {
    return (user != null) ? user.name : '---';
  }
}
