// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wr_app/api/mock.dart';
import 'package:wr_app/model/user.dart';
import 'package:wr_app/api/user.dart';
import 'package:wr_app/store/logger.dart';

/// FireStore Auth
final FirebaseAuth fbAuth = FirebaseAuth.instance;

/// ユーザーデータストア
class UserStore with ChangeNotifier {
  factory UserStore() {
    return _cache;
  }

  UserStore._internal() {
    Logger.log('✨ UserStore._internal()');

    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      Logger.log('\t load SharedPreferences');
    });
  }

  /// シングルトンインスタンス
  static final UserStore _cache = UserStore._internal();

  /// Shared prefs
  static SharedPreferences _prefs;

  /// Firebase User
  FirebaseUser fbUser;

  /// ユーザーデータ
  User user = User(
      name: '',
      point: 0,
      age: 0,
      email: '',
      favorites: {},
      testLimitCount: 3,
      userId: '',
      uuid: '');

  /// 成功トーストを出す
  void successToast(String message) {
    Logger.log('\t ✔ $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.lightGreen,
    );
  }

  /// エラートーストを出す
  void errorToast(Exception e) {
    Logger.log('\t⚠ $e');
    Fluttertoast.showToast(
      msg: 'エラーが発生',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }

  /// ユーザーデータを習得します
  Future<User> callReadUser() async {
    Logger.log('callReadUser()');

    try {
      final res = await readUser();
      return res.user;
    } on Exception catch (e) {
      errorToast(e);
      return null;
    }
  }

  /// get Google AuthCredential
  Future<AuthCredential> getGoogleAuthCredential() async {
    final _googleSignIn = GoogleSignIn();
    // try google sign in
    var _user = _googleSignIn.currentUser;
    _user ??= await _googleSignIn.signInSilently();
    _user ??= await _googleSignIn.signIn();
    if (_user == null) {
      return null;
    }

    // google user -> credential
    final _gauth = await _user.authentication;
    final _credential = GoogleAuthProvider.getCredential(
      idToken: _gauth.idToken,
      accessToken: _gauth.accessToken,
    );

    return _credential;
  }

  /// Sign in with google
  /// see <https://qiita.com/unsoluble_sugar/items/95b16c01b456be19f9ac>
  Future<void> signInWithGoogle() async {
    try {
      final _credential = await getGoogleAuthCredential();
      assert(_credential != null);

      // credential -> firebase user
      fbUser = (await fbAuth.signInWithCredential(_credential)).user;
    } on Exception catch (e) {
      print(e);
    }
  }

  /// Sign up with Google
  Future<void> signUpWithGoogle() async {
    try {
      final _credential = await getGoogleAuthCredential();
      assert(_credential != null);

      print(_credential);

      // credential -> firebase user
      fbUser = (await fbAuth.signInWithCredential(_credential)).user;

      final res = await createUser(
          name: fbUser.displayName, email: fbUser.email, age: 0);

      print(res.user.toJson());

      user = res.user;

      user = dummyUser();
      return;
    } on Exception catch (e) {
      print(e);
    }
  }

  /// モックでサインインする
  Future<void> signInWithMock({
    @required String email,
    @required String password,
  }) async {
    // auth = await _signInAuth(email: email, password: password);

    // Logger.log('\t ✔ user sign in ${auth.uid}');

    user = dummyUser();

    Logger.log('\t ✔ user fetched ${user.name}');

    successToast('ログインしました');

    notifyListeners();
  }

  /// Firebase Auth にサインインしユーザーデータを取得する
  Future<void> signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      fbUser = await _signInAuth(email: email, password: password);

      Logger.log('\t ✔ user sign in ${fbUser.uid}');

      user = await callReadUser();

      Logger.log('\t ✔ user fetched ${user.name}');

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
      final _result = await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // final _result = await _auth.signInAnonymously();

      return _result.user;
    } on Exception catch (e) {
      errorToast(e);
      return null;
    }
  }

  /// ゲストユーザーかどうか
  bool _isGuest() {
    return fbUser.isAnonymous;
  }

  /// テストAPIを呼ぶ
  Future<void> callTestAPI() async {
    Logger.log('callTestAPI');

    try {
      final data = await test();

      successToast('成功');

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// ユーザーを作成します
  Future<void> callCreateUser({
    @required String name,
    @required String email,
    @required int age,
  }) async {
    try {
      final uuid = fbUser.uid;
      final userId = fbUser.uid;

      Logger.log(
          '\tcallCreateUser(uuid: $uuid, name: $name, email: $email, age: $age)');
      final data = await createUser(
          uuid: uuid, userId: userId, name: name, email: email, age: age);

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
    Logger.log('\tcallFavoritePhrase()');

    try {
      favoritePhrase(uid: fbUser.uid, phraseId: phraseId, value: value)
          .then((res) {
        successToast(value ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
      });

      user.favorites[phraseId] = value;

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// 初回起動時か
  bool get firstLaunch {
    return _prefs?.getBool('first_launch') ?? true;
  }

  /// 初回起動時フラグをセットします
  void setFirstLaunch({bool flag}) {
    _prefs.setBool('first_launch', flag);
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int point}) async {
    Logger.log('\tcallGetPoint()');

    try {
      final data = await getPoint(uid: fbUser.uid, point: point);

      Logger.log(data.toString());

      successToast('$pointポイントゲットしました');

      user.point += point;

      notifyListeners();
    } on Exception catch (e) {
      errorToast(e);
    }
  }

  /// テストを受ける
  Future<void> callDoTest() async {
    Logger.log('\callDoTest()');

    try {
      await doTest();

      Logger.log('success');

      user.testLimitCount--;

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
