// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_digest.dart';
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

  Future<void> signUpWithGoogle() async {
    try {
      _user = await _userService.signUpWithGoogle();
      InAppLogger.debugJson(_user.toJson());
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Sign in with SIWA
  Future<void> signInWithSignInWithApple() async {
    try {
      _user = await _userService.signInWithSignInWithApple();
      InAppLogger.debugJson(_user.toJson());
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Sign up with SIWA
  Future<void> signUpWithSignInWithApple() async {
    try {
      _user = await _userService.signUpWithSignInWithApple();
      InAppLogger.debugJson(_user.toJson());
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  Future<void> signInWithApple() async {
    try {
      _user = await _userService.signInWithSignInWithApple();
      InAppLogger.debugJson(_user.toJson());
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  Future<void> signOut() async {
    InAppLogger.info('✔ user signed out');
    return _userService.signOut();
  }

  /// メールアドレスとパスワードでログイン
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      _user = await _userService.signInWithEmailAndPassword(email, password);

      InAppLogger.info('✔ loginWithEmailAndPassword');
      InAppLogger.debugJson(_user.toJson());
      notifyListeners();
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Googleでログイン
  Future<void> loginWithGoogle() async {
    try {
      _user = await _userService.signUpWithGoogle();
      InAppLogger.info('✔ loginWithGoogle');
      notifyListeners();
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// メールアドレスとパスワードでサインアップ
  Future<void> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String age,
    @required String name,
  }) async {
    try {
      _user = await _userService.signUpWithEmailAndPassword(
          email: email, password: password, age: age, name: name);
      InAppLogger.info('✔ signUpWithEmailAndPassword');
      notifyListeners();

      NotifyToast.success('ログインしました');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// update Email
  Future<void> setEmail({@required String email}) async {
    try {
      _user = await _userService.updateEmail(user: _user, newEmail: email);
      notifyListeners();

      NotifyToast.success('Emailを変更しました');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// update age
  Future<void> setAge({@required String age}) async {
    try {
      _user = await _userService.updateAge(user: _user, age: age);
      notifyListeners();

      NotifyToast.success('ageを変更しました');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// update password
  Future<void> setPassword(
      {@required String currentPassword, @required String newPassword}) async {
    try {
      await _userService.updatePassword(
          currentPassword: currentPassword, newPassword: newPassword);
      notifyListeners();

      NotifyToast.success('passwordを変更しました');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Test API
  Future<void> test() async {
    InAppLogger.info('callTestAPI()');

    try {
      await _userService.test();
      notifyListeners();
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// フレーズをお気に入りに登録します
  Future<void> favoritePhrase({
    @required String phraseId,
    @required bool favorite,
  }) async {
    const listId = 'default';

    try {
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
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// 受講可能回数をリセット
  Future<void> resetTestLimitCount() async {
    try {
      _user = await _userService.resetTestCount(user: _user);

      notifyListeners();

      InAppLogger.info('受講可能回数がリセットされました');
      NotifyToast.success('受講可能回数がリセットされました');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// ポイントを習得します
  Future<void> callGetPoint({@required int points}) async {
    try {
      _user = await _userService.getPoints(user: _user, points: points);
      notifyListeners();

      await sendEvent(
        event: AnalyticsEvent.pointGet,
        parameters: {'points': points},
      );
      NotifyToast.success('$points ポイントゲットしました');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// テストを受ける
  Future<void> doTest({@required String sectionId}) async {
    try {
      _user = await _userService.doTest(user: _user, sectionId: sectionId);
      notifyListeners();

      await sendEvent(
        event: AnalyticsEvent.doTest,
        parameters: {'sectionId': sectionId},
      );

      InAppLogger.info('doTest');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// テスト結果
  Future<void> sendTestScore(
      {@required String sectionId, @required int score}) async {
    try {
      _user = await _userService.sendTestResult(
          user: _user, sectionId: sectionId, score: score);
      notifyListeners();

      InAppLogger.info('sendTestScore');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// プランを変更
  Future<void> changePlan(Membership membership) async {
    try {
      _user =
          await _userService.changePlan(user: _user, membership: membership);

      notifyListeners();
      if (membership == Membership.pro) {
        await sendEvent(event: AnalyticsEvent.upGrade);
      }

      InAppLogger.info('membership to be $membership');
      NotifyToast.success('$membership');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// create favorite list
  Future<void> createFavoriteList({
    @required String name,
  }) async {
    try {
      _user = await _userService.createFavoriteList(name: name);

      notifyListeners();

      InAppLogger.info('createFavoriteList $name');
      NotifyToast.success('createFavoriteList $name');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// delete favorite list
  Future<void> deleteFavoriteList({
    @required String listId,
  }) async {
    try {
      _user = await _userService.deleteFavoriteList(listId: listId);

      notifyListeners();

      InAppLogger.info('deleteFavoriteList $listId');
      NotifyToast.success('createFavoriteList $listId');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// exist phrase in favorites
  bool existPhraseInFavoriteList({
    @required String phraseId,
  }) {
    return _user.favorites.values
        .any((list) => list.favoritePhraseIds.containsKey(phraseId));
  }

  /// create note
  Future<void> createPhrasesList({
    @required String title,
  }) async {
    try {
      _user = await _userService.createFavoriteList(name: title);

      notifyListeners();

      InAppLogger.info('createPhrasesList $title');
      NotifyToast.success('createPhrasesList $title');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
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
    return _user.notes.values.any((list) => list.phrases.containsKey(phraseId));
  }

  /// create note
  Future<void> createNote({
    @required String title,
  }) async {
    try {
      final note = await _noteService.createNote(title: title);
      _user.notes[note.id] = note;

      notifyListeners();

      InAppLogger.info('createNote ${note.id}');
      NotifyToast.success('createNote ${note.id}');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// update note title
  Future<void> updateNoteTitle({
    @required String noteId,
    @required String title,
  }) async {
    try {
      final note =
          await _noteService.updateNoteTitle(noteId: noteId, title: title);
      _user.notes[note.id] = note;

      notifyListeners();

      InAppLogger.info('updateNoteTitle ${note.id}');
      NotifyToast.success('updateNoteTitle ${note.id}');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// update note isDefault
  Future<void> updateDefaultNote({@required String noteId}) async {
    try {
      final note = await _noteService.updateDefaultNote(noteId: noteId);
      _user.notes[note.id] = note;

      notifyListeners();

      InAppLogger.info('updateDefaultNote ${note.id}');
      NotifyToast.success('updateDefaultNote ${note.id}');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// delete note
  Future<void> deleteNote({@required String noteId}) async {
    try {
      await _noteService.deleteNote(noteId: noteId);
      _user.notes.remove(noteId);

      notifyListeners();

      InAppLogger.info('updateDefaultNote ${noteId}');
      NotifyToast.success('updateDefaultNote ${noteId}');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// add phrase
  Future<void> addPhraseInNote({
    @required String noteId,
    @required NotePhrase phrase,
  }) async {
    try {
      final note =
          await _noteService.addPhraseInNote(noteId: noteId, phrase: phrase);
      _user.notes[noteId] = note;

      notifyListeners();

      InAppLogger.info('addPhraseInNote ${noteId}');
      NotifyToast.success('addPhraseInNote ${noteId}');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// update phrase
  Future<void> updatePhraseInNote({
    @required String noteId,
    @required String phraseId,
    @required NotePhrase phrase,
  }) async {
    try {
      final note = await _noteService.updatePhraseInNote(
        noteId: noteId,
        phraseId: phraseId,
        phrase: phrase,
      );
      _user.notes[note.id] = note;

      notifyListeners();
    } catch (e) {
      InAppLogger.info('updatePhraseInNote ${noteId}');
      NotifyToast.success('updatePhraseInNote ${noteId}');
    }
  }

  /// delete phrase
  Future<void> deletePhraseInNote({
    @required String noteId,
    @required String phraseId,
  }) async {
    try {
      await _noteService.deletePhraseInNote(noteId: noteId, phraseId: phraseId);
      _user.notes[noteId].phrases.remove(phraseId);

      notifyListeners();

      InAppLogger.info('deletePhraseInNote ${noteId}');
      NotifyToast.success('deletePhraseInNote ${noteId}');
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }
}
