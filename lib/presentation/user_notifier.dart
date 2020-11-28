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

  final UserService _userService;

  /// ユーザーデータ
  User user = User.empty();

  /// singleton
  static UserNotifier _cache;

  bool existUserData = false;

  /// 過去データのマイグレーションの実行
  Future<void> migrationUserData({
    @required String uid,
  }) async {
    await _userService.migrationUserData(uid: uid);
  }

  /// ユーザーデータを取得
  Future<void> fetchUser({@required String uid}) async {
    assert(uid != '');
    user = await _userService.fetchUser(uid: uid);
    existUserData = true;
    notifyListeners();
  }

  /// update name
  Future<void> setName({@required String name}) async {
    user.name = name;
    user = await _userService.updateUser(user: user);
    notifyListeners();

    InAppLogger.debug('setName $name');
    NotifyToast.success('名前を変更しました');
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    user = await _userService.setTestCount(user: user, count: 3);

    notifyListeners();

    InAppLogger.debug('受講可能回数がリセットされました');
    // NotifyToast.success('受講可能回数がリセットされました');
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int points}) async {
    user = await _userService.getPoints(uuid: user.uuid, points: points);
    notifyListeners();

    await sendEvent(
      event: AnalyticsEvent.pointGet,
      parameters: {'points': points},
    );
    InAppLogger.debug('$points ポイントゲットしました');
  }

  /// テストを受ける
  Future<void> doTest({@required String sectionId}) async {
    user = await _userService.doTest(user: user, sectionId: sectionId);
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
    user = await _userService.sendTestResult(
        user: user, sectionId: sectionId, score: score);
    notifyListeners();

    InAppLogger.info('sendTestScore');
  }

  /// プランを変更
  Future<void> changePlan(Membership membership) async {
    user = await _userService.changePlan(user: user, membership: membership);

    notifyListeners();
    if (membership == Membership.pro) {
      await sendEvent(event: AnalyticsEvent.upGrade);
    }

    InAppLogger.info('membership to be $membership');
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
    return user.notes.values
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
    final heatMap = calcHeatMap(user.testResults);
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
    return _userService.checkTestStreaks(user: user);
  }

  /// search user from user id
  Future<User> searchUserFromUserId({@required String userId}) {
    return _userService.searchUserFromUserId(userId: userId);
  }

  Future<void> introduceFriend({
    @required String introduceeId,
  }) async {
    // TODO: イケてない
    await _userService.introduceFriend(introduceeUserId: introduceeId);
    user = await _userService.fetchUser(uid: _userService.getUid());
    notifyListeners();
  }
}
