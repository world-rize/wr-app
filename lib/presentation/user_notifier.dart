// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
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
  User _user = User.empty();
  User get user => _user;
  set user(User user) => _user = user;

  /// singleton
  static UserNotifier _cache;

  factory UserNotifier({
    @required UserService userService,
  }) {
    return _cache ??= UserNotifier._internal(
      userService: userService,
    );
  }

  UserNotifier._internal({
    @required UserService userService,
  }) : _userService = userService;

  /// ユーザーデータを取得
  Future<void> fetchUser() async {
    _user = await _userService.readUser();
    notifyListeners();
  }

  /// update age
  Future<void> setAge({@required String age}) async {
    _user = await _userService.updateAge(user: _user, age: age);
    notifyListeners();

    NotifyToast.success('ageを変更しました');
  }

  /// フレーズをお気に入りに登録します
  Future<void> favoritePhrase({
    @required String phraseId,
    @required bool favorite,
  }) async {
    const listId = 'default';

    // 仮反映
    if (favorite) {
      _user.favorites[listId].updatePhrase(
          phraseId,
          FavoritePhraseDigest(
            id: phraseId,
            createdAt: DateTime.now(),
          ));
    } else {
      _user.favorites[listId].deletePhrase(phraseId);
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

    InAppLogger.debug(favorite ? 'お気に入りに登録しました' : 'お気に入りを解除しました');
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    _user = await _userService.resetTestCount(user: _user);

    notifyListeners();

    InAppLogger.debug('受講可能回数がリセットされました');
    // NotifyToast.success('受講可能回数がリセットされました');
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int points}) async {
    _user = await _userService.getPoints(user: _user, points: points);
    notifyListeners();

    await sendEvent(
      event: AnalyticsEvent.pointGet,
      parameters: {'points': points},
    );
    InAppLogger.debug('$points ポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest({@required String sectionId}) async {
    _user = await _userService.doTest(user: _user, sectionId: sectionId);
    notifyListeners();

    await sendEvent(
      event: AnalyticsEvent.doTest,
      parameters: {'sectionId': sectionId},
    );

    InAppLogger.info('doTest');
  }

  /// テスト結果
  Future<void> sendTestScore(
      {@required String sectionId, @required int score}) async {
    _user = await _userService.sendTestResult(
        user: _user, sectionId: sectionId, score: score);
    notifyListeners();

    InAppLogger.info('sendTestScore');
  }

  /// プランを変更
  Future<void> changePlan(Membership membership) async {
    _user = await _userService.changePlan(user: _user, membership: membership);

    notifyListeners();
    if (membership == Membership.pro) {
      await sendEvent(event: AnalyticsEvent.upGrade);
    }

    InAppLogger.info('membership to be $membership');
  }

  /// create favorite list
  Future<void> createFavoriteList({
    @required String name,
  }) async {
    _user = await _userService.createFavoriteList(name: name);

    notifyListeners();

    InAppLogger.info('createFavoriteList $name');
  }

  /// delete favorite list
  Future<void> deleteFavoriteList({
    @required String listId,
  }) async {
    _user = await _userService.deleteFavoriteList(listId: listId);

    notifyListeners();

    InAppLogger.info('deleteFavoriteList $listId');
    // NotifyToast.success('createFavoriteList $listId');
  }

  /// exist phrase in favorites
  bool existPhraseInFavoriteList({
    @required String phraseId,
  }) {
    return _user.favorites.values
        .any((list) => list.phrases.any((p) => p.id == phraseId));
  }

  /// create note
  Future<void> createPhrasesList({
    @required String title,
  }) async {
    _user = await _userService.createFavoriteList(name: title);

    notifyListeners();

    InAppLogger.info('createPhrasesList $title');
    NotifyToast.success('createPhrasesList $title');
  }

  /// get highest score
  int getHighestScore({
    @required String sectionId,
  }) {
    // TODO
    return 0;
  }

  /// exist phrase in notes
  bool existPhraseInNotes({
    @required String phraseId,
  }) {
    return _user.notes.values
        .any((list) => list.phrases.any((p) => p.id == phraseId));
  }

  /// exist phrase in favorites
  bool existPhraseInFavorites({
    @required String phraseId,
  }) {
    return _user.favorites.values
        .any((list) => list.phrases.any((p) => p.id == phraseId));
  }

  /// calculates heatMap of testResult
  Map<DateTime, int> calcHeatMap(List<TestResult> results) {
    final dates = results.map((r) => Jiffy(r.date)..startOf(Units.DAY));
    return groupBy<Jiffy, Jiffy>(dates, (d) => d).map(
        (key, value) => MapEntry<DateTime, int>(key.local(), value.length));
  }

  /// calculates test 30days streaks
  int calcTestStreaks() {
    final heatMap = calcHeatMap(_user.statistics.testResults);
    var i = 0;
    for (var day = Jiffy()..startOf(Units.DAY);
        heatMap.containsKey(day);
        day = day..subtract(days: 1)) {
      i++;
    }
    return i;
  }

  /// check test 30days streaks
  Future<bool> checkTestStreaks() async {
    return _userService.checkTestStreaks();
  }

  /// search user from user id
  Future<User> searchUserFromUserId({@required String userId}) {
    return _userService.searchUserFromUserId(userId: userId);
  }

  Future<void> introduceFriend({@required String introduceeId}) async {
    await _userService.introduceFriend(introduceeUserId: introduceeId);
    _user = await _userService.readUser();
    notifyListeners();
  }

  /// TODO: purchase Amazon Gift
  /// TODO: purchase iTunes Gift
}
