// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wr_app/api/debug/test.dart';
import 'package:wr_app/api/user/index.dart';
import 'package:wr_app/model/membership.dart';
import 'package:wr_app/model/phrase/phrase.dart';
import 'package:wr_app/model/user.dart';
import 'package:wr_app/store/logger.dart';
import 'package:wr_app/ui/common/toast.dart';

// TODO(someone): リファクタリング

/// FireStore Auth
final FirebaseAuth fbAuth = FirebaseAuth.instance;

/// ユーザーデータストア
class UserStore with ChangeNotifier {
  /// ## firebase ログイン方法
  /// - email & password
  /// - google sign in
  /// - Sign in With Apple
  /// - mock(test)
  /// ## FirebaseUser -> User

  /// シングルトンインスタンス
  static UserStore _cache;

  factory UserStore() {
    return _cache ??= UserStore._internal();
  }

  UserStore._internal() {
    init();
  }

  /// Firebase User
  FirebaseUser _fbUser;

  /// ユーザーデータ
  User user;

  /// 初期化
  Future<void> init() async {
    _configureAuthStateChanged();

    InAppLogger.log('✨ init UserStore');
  }

  /// 自動ログイン
  void _configureAuthStateChanged() {
    fbAuth.onAuthStateChanged.listen((fbUser) {
      if (fbUser != null) {
        _setAuth(fbUser);
      }
    });
  }

  /// get Google AuthCredential
  // TODO(any): refactoring
  Future<AuthCredential> _getGoogleAuthCredential() async {
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

  /// try to auto login. will be called when app started.
  Future<bool> autoLogin() async {
    final fbUser = await fbAuth.currentUser();
    if (fbUser != null) {
      _setAuth(fbUser);
      return true;
    } else {
      return false;
    }
  }

  /// Sign up with Google
  // TODO(any): deprecated
  Future<void> signUpWithGoogle() async {
    final _credential = await _getGoogleAuthCredential();
    assert(_credential != null);

    // credential -> firebase user
    final signInResponse =
        await fbAuth.signInWithCredential(_credential).catchError(print);

    assert(signInResponse != null);

    final functionResponse = await createUser(
      uuid: signInResponse.user.uid,
      userId: signInResponse.user.uid,
      name: signInResponse.user.displayName,
      email: signInResponse.user.email,
      age: 0,
    ).catchError(print);

    assert(functionResponse != null);

    InAppLogger.log(user.toJson().toString(), type: 'user');
    user = functionResponse.user;

    return;
  }

  /// ユーザーデータを取得する
  Future<void> signIn() async {
    try {
      user = await callReadUser();

      InAppLogger.log('\t ✔ user fetched ${user.name}');

      NotifyToast.success('ログインしました');

      notifyListeners();
    } on Exception catch (e) {
      print(e);
      NotifyToast.error(e);
    }
  }

  Future<void> signOut() async {
    await _unauthorize();
    user = null;

    InAppLogger.log('\t ✔ user signed out', type: 'user');
  }

  /// create firebase auth with email & password
  Future<FirebaseUser> _createAuthWithEmailAndPassword(
      String email, String password) async {
    final _result = await fbAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _result.user;
  }

  /// authorize with email & password
  Future<FirebaseUser> _authorizeWithEmailAndPassword(
      String email, String password) async {
    try {
      final _result = await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _result.user;
    } on Exception catch (e) {
      NotifyToast.error(e);
      rethrow;
    }
  }

  /// authorize with google
  Future<FirebaseUser> _authorizeWithGoogleSignIn() async {
    final _credential = await _getGoogleAuthCredential();
    assert(_credential != null);

    // credential -> firebase user
    final authResult =
        await fbAuth.signInWithCredential(_credential).catchError(print);

    assert(authResult != null);

    return authResult.user;
  }

  /// authorize with sign in apple
  Future<FirebaseUser> _authorizeWithSignInWithApple() async {
    throw UnimplementedError();
  }

  /// unauthorize
  Future<void> _unauthorize() async {
    await fbAuth.signOut();
    _fbUser = null;
  }

  void _setAuth(FirebaseUser user) {
    _fbUser = user;

    InAppLogger.log('set firebase auth ${user.email}');
  }

  /// メールアドレスとパスワードでログイン
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    final auth = await _authorizeWithEmailAndPassword(email, password);
    _setAuth(auth);

    user = await callReadUser();
  }

  /// Googleでログイン
  Future<void> loginWithGoogle() async {
    final auth = await _authorizeWithGoogleSignIn();
    _setAuth(auth);

    user = await callReadUser();
  }

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    final auth = await _createAuthWithEmailAndPassword(email, password);
    _setAuth(auth);

    user = await callReadUser();
  }

  /// テストAPIを呼ぶ
  Future<void> callTestAPI() async {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    InAppLogger.log('callTestAPI');

    try {
      final data = await test();

      NotifyToast.success('成功');

      notifyListeners();
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  /// ユーザーデータを習得します
  Future<User> callReadUser() async {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    InAppLogger.log('callReadUser()', type: 'user');

    try {
      final res = await readUser();
      return res.user;
    } on Exception catch (e) {
      NotifyToast.error(e);
      return null;
    }
  }

  /// ユーザーを作成します
  Future<void> callCreateUser({
    @required String name,
    @required String email,
    @required int age,
  }) async {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    try {
      final uuid = _fbUser.uid;
      final userId = _fbUser.uid;

      InAppLogger.log(
          '\tcallCreateUser(uuid: $uuid, name: $name, email: $email, age: $age)');
      final data = await createUser(
          uuid: uuid, userId: userId, name: name, email: email, age: age);

      user = data.user;

      NotifyToast.success('ユーザーを作成しました');

      notifyListeners();
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  /// フレーズをお気に入りに登録します
  Future<void> callFavoritePhrase(
      {@required String phraseId, @required bool value}) {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    InAppLogger.log('\tcallFavoritePhrase()');

    try {
      favoritePhrase(uid: _fbUser.uid, phraseId: phraseId, value: value)
          .then((res) {
        NotifyToast.success(value ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
      });

      user.favorites[phraseId] = value;

      notifyListeners();
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  ///
  bool favorited(Phrase phrase) {
    return user.favorites.containsKey(phrase.id) && user.favorites[phrase.id];
  }

  /// 受講可能回数をリセット
  // TODO(any): call api
  Future<void> resetTestLimitCount() async {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    InAppLogger.log('\tresetTestLimitCount()');

    try {
      user.testLimitCount = 3;

      InAppLogger.log('受講可能回数がリセットされました');
      NotifyToast.success('受講可能回数がリセットされました');

      notifyListeners();
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int point}) async {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    InAppLogger.log('\tcallGetPoint()');

    try {
      final data = await getPoint(uid: _fbUser.uid, point: point);

      InAppLogger.log(data.toString());

      NotifyToast.success('$pointポイントゲットしました');

      user.point += point;

      notifyListeners();
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  /// テストを受ける
  Future<void> callDoTest() async {
    if (_fbUser == null) {
      throw Exception('firebase not authorized');
    }

    InAppLogger.log('\callDoTest()');

    try {
      // await doTest();

      InAppLogger.log('success');

      user.testLimitCount--;

      notifyListeners();
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  /// 名前を取得
  String displayName() {
    return (user != null) ? user.name : '---';
  }

  bool get isPremium => user.membership == Membership.pro;

  /// プランを変更
  void changePlan(Membership membership) {
    user.membership = membership;

    InAppLogger.log('membership to be $membership');

    NotifyToast.success('$membership');

    notifyListeners();
  }
}
