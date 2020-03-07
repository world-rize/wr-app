// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  /// Firebase Auth にログイン
  Future<void> signIn() async {
    final _result = await _auth.signInAnonymously();
    print('anonymous sign in');
    _user = _result.user;
  }

  /// ゲストユーザーかどうか
  bool _isGuest() {
    return _user.isAnonymous;
  }

  /// 名前を取得
  String displayName() {
    return _isGuest() ? 'ゲスト' : _user.displayName;
  }
}
