// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ユーザーデータストア
class UserNotifier with ChangeNotifier {
  final UserService _userService;

  /// ユーザーデータ
  User _user;

  /// logged in?
  bool get loggedIn => _user != null;

  User getUser() => _user;

  /// singleton
  static UserNotifier _cache;

  factory UserNotifier({@required UserService service}) {
    return _cache ??= UserNotifier._internal(service: service);
  }

  UserNotifier._internal({@required UserService service})
      : _userService = service;

  Future<void> signUpWithGoogle() async {
    _user = await _userService.signUpWithGoogle();
    InAppLogger.debugJson(_user.toJson());
  }

  Future<void> signOut() async {
    InAppLogger.info('✔ user signed out');
    return _userService.signOut();
  }

  /// メールアドレスとパスワードでログイン
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    _user = await _userService.signInWithEmailAndPassword(email, password);
    InAppLogger.info('✔ loginWithEmailAndPassword');
    InAppLogger.debugJson(_user.toJson());
    notifyListeners();
  }

  /// Googleでログイン
  Future<void> loginWithGoogle() async {
    _user = await _userService.signUpWithGoogle();
    InAppLogger.info('✔ loginWithGoogle');
    notifyListeners();
  }

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String age,
    @required String name,
  }) async {
    _user = await _userService.signUpWithEmailAndPassword(
        email: email, password: password, age: age, name: name);
    InAppLogger.info('✔ signUpWithEmailAndPassword');
    notifyListeners();

    NotifyToast.success('ログインしました');
  }

  /// update Email
  Future<void> setEmail({@required String email}) async {
    _user = await _userService.updateEmail(user: _user, newEmail: email);
    notifyListeners();

    NotifyToast.success('Emailを変更しました');
  }

  /// update age
  Future<void> setAge({@required String age}) async {
    _user = await _userService.updateAge(user: _user, age: age);
    notifyListeners();

    NotifyToast.success('ageを変更しました');
  }

  /// update password
  Future<void> setPassword(
      {@required String currentPassword, @required String newPassword}) async {
    await _userService.updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
    notifyListeners();

    NotifyToast.success('passwordを変更しました');
  }

  /// Test API
  Future<void> test() async {
    InAppLogger.info('callTestAPI()');
    await _userService.test();
    notifyListeners();
  }

  /// フレーズをお気に入りに登録します
  Future<void> favoritePhrase({
    @required String phraseId,
    @required bool favorite,
  }) async {
    const listId = 'default';

    // 仮反映
    if (favorite) {
      _user.favorites[listId].favoritePhraseIds[phraseId] =
          FavoritePhraseDigest(
        id: phraseId,
        createdAt: DateTime.now(),
      );
    } else {
      _user.favorites[listId].favoritePhraseIds.remove(phraseId);
    }

    notifyListeners();

    // 本反映
    _user = await _userService.favorite(
      user: _user,
      listId: listId,
      phraseId: phraseId,
      favorite: favorite,
    );
    notifyListeners();

    NotifyToast.success(favorite ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    _user = await _userService.resetTestCount(user: _user);

    notifyListeners();

    InAppLogger.info('受講可能回数がリセットされました');
    NotifyToast.success('受講可能回数がリセットされました');
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int points}) async {
    _user = await _userService.getPoints(user: _user, points: points);
    notifyListeners();

    await sendEvent(
      event: AnalyticsEvent.pointGet,
      parameters: {'points': points},
    );
    NotifyToast.success('$points ポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest({@required String sectionId}) async {
    await _userService.doTest(user: _user, sectionId: sectionId);
    notifyListeners();
  }

  /// プランを変更
  Future<void> changePlan(Membership membership) async {
    _user = await _userService.changePlan(user: _user, membership: membership);

    notifyListeners();
    if (membership == Membership.pro) {
      await sendEvent(event: AnalyticsEvent.upGrade);
    }

    InAppLogger.info('membership to be $membership');
    NotifyToast.success('$membership');
  }
}
