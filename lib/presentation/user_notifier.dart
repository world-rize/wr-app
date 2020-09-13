// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/usecase/note_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// ユーザーデータストア
class UserNotifier with ChangeNotifier {
  // TODO: エラーハンドリング
  final UserService _userService;
  final NoteService _noteService;

  /// ユーザーデータ
  User _user;

  /// logged in?
  bool get loggedIn => _user != null;

  User getUser() {
    if (_user == null) {
      throw Exception('user is null');
    }
    return _user;
  }

  /// singleton
  static UserNotifier _cache;

  factory UserNotifier({
    @required UserService userService,
    @required NoteService noteService,
  }) {
    return _cache ??= UserNotifier._internal(
      userService: userService,
      noteService: noteService,
    );
  }

  UserNotifier._internal({
    @required UserService userService,
    @required NoteService noteService,
  })  : _userService = userService,
        _noteService = noteService;

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    InAppLogger.info('✔ signUpWithEmailAndPassword');
    _user = await _userService.signUpWithEmailAndPassword(
        email: email, password: password, age: '0', name: name);
    notifyListeners();
  }

  /// Google Sign in でサインアップ
  Future<void> signUpWithGoogle(String name) async {
    _user = await _userService.signUpWithGoogle(name);
    notifyListeners();
  }

  /// Sign up with SIWA
  Future<void> signUpWithApple(String name) async {
    _user = await _userService.signUpWithApple(name);
    notifyListeners();
  }

  /// メールアドレスとパスワードでログイン
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _user = await _userService.signInWithEmailAndPassword(email, password);
    InAppLogger.info('✔ signInWithEmailAndPassword');
    notifyListeners();
  }

  /// Googleでログイン
  Future<void> signInWithGoogle() async {
    _user = await _userService.signInWithGoogle();
    InAppLogger.info('✔ signInWithGoogle');
    notifyListeners();
  }

  /// Sign In With Apple でログイン
  Future<void> signInWithApple() async {
    _user = await _userService.signInWithApple();
    notifyListeners();
  }

  Future<void> login() async {
    _user = await _userService.readUser();
    await _userService.login();
    notifyListeners();
  }

  Future<void> signOut() async {
    InAppLogger.info('✔ user signed out');
    return _userService.signOut();
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
    NotifyToast.success('$membership');
  }

  /// create favorite list
  Future<void> createFavoriteList({
    @required String name,
  }) async {
    _user = await _userService.createFavoriteList(name: name);

    notifyListeners();

    InAppLogger.info('createFavoriteList $name');
    NotifyToast.success('createFavoriteList $name');
  }

  /// delete favorite list
  Future<void> deleteFavoriteList({
    @required String listId,
  }) async {
    _user = await _userService.deleteFavoriteList(listId: listId);

    notifyListeners();

    InAppLogger.info('deleteFavoriteList $listId');
    NotifyToast.success('createFavoriteList $listId');
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

  /// create note
  Future<void> createNote({
    @required String title,
  }) async {
    final note = await _noteService.createNote(title: title);
    _user.notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('createNote ${note.id}');
    NotifyToast.success('createNote ${note.id}');
  }

  /// update note title
  Future<void> updateNoteTitle({
    @required String noteId,
    @required String title,
  }) async {
    final note =
        await _noteService.updateNoteTitle(noteId: noteId, title: title);
    _user.notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('updateNoteTitle ${note.id}');
    NotifyToast.success('updateNoteTitle ${note.id}');
  }

  /// update note isDefault
  Future<void> updateDefaultNote({@required String noteId}) async {
    final note = await _noteService.updateDefaultNote(noteId: noteId);
    _user.notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('updateDefaultNote ${note.id}');
    NotifyToast.success('updateDefaultNote ${note.id}');
  }

  /// delete note
  Future<void> deleteNote({@required String noteId}) async {
    await _noteService.deleteNote(noteId: noteId);
    _user.notes.remove(noteId);

    notifyListeners();

    InAppLogger.info('updateDefaultNote ${noteId}');
    NotifyToast.success('updateDefaultNote ${noteId}');
  }

  /// add phrase
  Future<void> addPhraseInNote({
    @required String noteId,
    @required NotePhrase phrase,
  }) async {
    final note =
        await _noteService.addPhraseInNote(noteId: noteId, phrase: phrase);
    _user.notes[noteId] = note;

    notifyListeners();

    InAppLogger.info('addPhraseInNote ${noteId}');
    NotifyToast.success('addPhraseInNote ${noteId}');
  }

  /// update phrase
  Future<void> updatePhraseInNote({
    @required String noteId,
    @required String phraseId,
    @required NotePhrase phrase,
  }) async {
    final note = await _noteService.updatePhraseInNote(
      noteId: noteId,
      phraseId: phraseId,
      phrase: phrase,
    );
    _user.notes[note.id] = note;

    notifyListeners();
  }

  /// delete phrase
  Future<void> deletePhraseInNote({
    @required String noteId,
    @required String phraseId,
  }) async {
    await _noteService.deletePhraseInNote(
      noteId: noteId,
      phraseId: phraseId,
    );
    _user.notes[noteId].phrases.remove(phraseId);

    notifyListeners();

    InAppLogger.info('deletePhraseInNote $noteId/$phraseId');
    NotifyToast.success('deletePhraseInNote $noteId/$phraseId');
  }

  /// achieve notePhrase
  Future<void> achievePhraseInNote({
    @required String noteId,
    @required String phraseId,
    @required bool achieve,
  }) async {
    await _noteService.achievePhraseInNote(
        noteId: noteId, phraseId: phraseId, achieve: achieve);

    final phrase = _user.notes[noteId].findByNotePhraseId(phraseId)
      ..achieved = achieve;
    _user.notes[noteId].updateNotePhrase(phraseId, phrase);

    notifyListeners();

    InAppLogger.info('achievePhraseInNote $noteId/$phraseId');
    NotifyToast.success('achievePhraseInNote $noteId/$phraseId');
  }

  /// calculates heatMap of testResult
  Map<Jiffy, int> _calcHeatMap(List<TestResult> results) {
    final dates = results.map((r) => Jiffy(r.date)..startOf(Units.DAY));
    return groupBy(dates, (d) => d)
        .map((key, value) => MapEntry(key, value.length));
  }

  /// calculates test 30days streaks
  int calcTestStreaks() {
    final heatMap = _calcHeatMap(_user.statistics.testResults);
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

  /// purchase item
  Future<void> purchaseItem({@required String itemId}) async {
    _user = await _userService.purchaseItem(user: _user, itemId: itemId);
    await _userService.updateUser(user: _user);
    notifyListeners();
  }

  Future<bool> isAlreadySignedIn() async {
    return _userService.isAlreadySignedIn();
  }

  Future<void> sendPasswordResetEmail() async {
    return _userService.sendPasswordResetEmail(_user.attributes.email);
  }

  /// TODO: purchase Amazon Gift
  /// TODO: purchase iTunes Gift
}
