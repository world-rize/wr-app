// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
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

  bool signedIn = false;

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
    _user = await _userService.readUser(uuid: _user.uuid);
    signedIn = true;
    notifyListeners();
  }

  /// update name
  Future<void> setName({@required String name}) async {
    _user.name = name;
    _user = await _userService.updateUser(user: _user);
    notifyListeners();

    InAppLogger.debug('setName $name');
    NotifyToast.success('名前を変更しました');
  }

  /// フレーズをお気に入りに登録します
  Future<void> favoritePhrase({
    @required String phraseId,
    @required bool favorite,
  }) async {
    // TODO: default以外に保存できるようにする
    final defaultFavoriteList = _user.getDefaultFavoriteList();
    // defaultふぁぼりてリスト以外に保存したらdeleteするときむずかしくね?
    if (favorite) {
      // false -> true
      _user = await _userService.favorite(
        uuid: _user.uuid,
        listId: defaultFavoriteList.id,
        phraseId: phraseId,
        favorite: favorite,
      );
      await Future.delayed(const Duration(milliseconds: 1000));
    } else {
      _user = await _userService.favorite(
        uuid: _user.uuid,
        listId: defaultFavoriteList.id,
        phraseId: phraseId,
        favorite: favorite,
      );
    }
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
    _user = await _userService.getPoints(uuid: _user.uuid, points: points);
    notifyListeners();

    await sendEvent(
      event: AnalyticsEvent.pointGet,
      parameters: {'points': points},
    );
    InAppLogger.debug('$points ポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest({@required String sectionId}) async {
    _user = await _userService.doTest(uuid: _user.uuid, sectionId: sectionId);
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
        uuid: _user.uuid, sectionId: sectionId, score: score);
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
    @required String title,
  }) async {
    _user =
        await _userService.createFavoriteList(uuid: _user.uuid, title: title);

    notifyListeners();

    InAppLogger.info('createFavoriteList $title');
  }

  /// delete favorite list
  Future<void> deleteFavoriteList({
    @required String uuid,
    @required String listId,
  }) async {
    _user = await _userService.deleteFavoriteList(uuid: uuid, listId: listId);

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
    _user =
        await _userService.createFavoriteList(uuid: _user.uuid, title: title);

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
    return _userService.checkTestStreaks(uuid: _user.uuid);
  }

  /// search user from user id
  Future<User> searchUserFromUserId({@required String userId}) {
    return _userService.searchUserFromUserId(userId: userId);
  }

  Future<void> introduceFriend({
    @required String introduceeId,
  }) async {
    await _userService.introduceFriend(
        uuid: _user.uuid, introduceeUserId: introduceeId);
    _user = await _userService.readUser(uuid: _user.uuid);
    notifyListeners();
  }
}
