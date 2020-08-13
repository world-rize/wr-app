// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/logger.dart';

// TODO: Error handling
// TODO: update api returns updated object
class UserService {
  const UserService({
    @required AuthRepository authPersistence,
    @required UserRepository userPersistence,
  })  : _userPersistence = userPersistence,
        _authPersistence = authPersistence;

  final AuthRepository _authPersistence;
  final UserRepository _userPersistence;

  /// sign up with Google
  Future<User> signUpWithGoogle() async {
    final res = await _authPersistence.signInWithGoogleSignIn();

    final req = CreateUserRequest(
      name: res.displayName,
      email: res.email,
      age: '0',
    );

    return _userPersistence.createUser(req);
  }

  /// sign up with email & password
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
    @required String age,
  }) async {
    final req = CreateUserRequest(
      name: name,
      age: age,
      email: email,
    );

    await _authPersistence.signUpWithEmailAndPassword(email, password);

    InAppLogger.debug('_authPersistence.signUpWithEmailAndPassword()');

    final user = await _userPersistence.createUser(req);

    InAppLogger.debug('_userPersistence.createUser()');

    return user;
  }

  /// sign up with SIWA
  Future<User> signUpWithSignInWithApple() async {
    final fbUser = await _authPersistence.signInWithSignInWithApple();

    InAppLogger.debug('_authPersistence.signInWithSignInWithApple()');

    // TODO: fbUSer.displayName will be null
    final req = CreateUserRequest(
      name: fbUser.displayName ?? '',
      age: '0',
      email: fbUser.email ?? '',
    );

    final user = await _userPersistence.createUser(req);

    InAppLogger.debug('_userPersistence.readUser()');

    return user;
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await _authPersistence.signInWithEmailAndPassword(email, password);

    InAppLogger.debug('_authPersistence.signInWithEmailAndPassword()');

    final user = await _userPersistence.readUser();

    InAppLogger.debug('_userPersistence.readUser()');

    return user;
  }

  /// sign in with apple
  Future<User> signInWithSignInWithApple() async {
    await _authPersistence.signInWithSignInWithApple();

    InAppLogger.debug('_authPersistence.signInWithSignInWithApple()');

    final user = await _userPersistence.readUser();

    InAppLogger.debug('_userPersistence.readUser()');

    return user;
  }

  /// sign out
  Future<void> signOut() {
    return _authPersistence.signOut();
  }

  /// call test api
  Future<void> test() async {
    return _userPersistence.test();
  }

  /// ユーザーデータを習得します
  Future<User> readUser() async {
    return _userPersistence.readUser();
  }

  /// フレーズをお気に入りに登録します
  Future<User> favorite({
    @required User user,
    @required String listId,
    @required String phraseId,
    @required bool favorite,
  }) async {
    final req = FavoritePhraseRequest(
        listId: 'default', phraseId: phraseId, favorite: favorite);
    return _userPersistence.favoritePhrase(req);
  }

  /// 受講可能回数をリセット
  Future<User> resetTestCount({
    @required User user,
  }) async {
    user.statistics.testLimitCount = 3;
    return _userPersistence.updateUser(user);
  }

  /// ポイントを習得します
  Future<User> getPoints({
    @required User user,
    @required int points,
  }) async {
    final req = GetPointRequest(
      points: points,
    );
    return _userPersistence.getPoint(req);
  }

  Future<User> updateAge({@required User user, @required String age}) async {
    user.attributes.age = age;
    return _userPersistence.updateUser(user);
  }

  /// upgrade to Pro or downgrade
  Future<User> changePlan({
    @required User user,
    @required Membership membership,
  }) {
    user.attributes.membership = membership;
    return _userPersistence.updateUser(user);
  }

  /// do test
  Future<User> doTest({
    @required User user,
    @required String sectionId,
  }) {
    return _userPersistence.doTest(DoTestRequest(sectionId: sectionId));
  }

  /// send result
  Future<User> sendTestResult({
    @required User user,
    @required String sectionId,
    @required int score,
  }) {
    return _userPersistence.sendTestResult(
        SendTestResultRequest(sectionId: sectionId, score: score));
  }

  /// update user
  Future<User> updateUser({@required User user}) {
    return _userPersistence.updateUser(user);
  }

  /// update password
  Future<void> updatePassword({
    @required String currentPassword,
    @required String newPassword,
  }) {
    return _authPersistence.updatePassword(currentPassword, newPassword);
  }

  /// update email
  Future<User> updateEmail({
    @required User user,
    @required String newEmail,
  }) async {
    user.attributes.email = newEmail;
    await _userPersistence.updateUser(user);
    await _authPersistence.updateEmail(newEmail);

    return user;
  }

  /// create favorite list
  Future<User> createFavoriteList({
    @required String name,
  }) {
    final req = CreateFavoriteListRequest(name: name);
    return _userPersistence.createFavoriteList(req);
  }

  /// delete favorite list
  Future<User> deleteFavoriteList({
    @required String listId,
  }) async {
    final req = DeleteFavoriteListRequest(listId: listId);
    return _userPersistence.deleteFavoriteList(req);
  }

  /// create note
  Future<User> createPhrasesList({
    @required String title,
  }) {
    final req = CreatePhrasesListRequest(title: title);
    return _userPersistence.createPhrasesList(req);
  }

  /// add phrase to note
  Future<User> addPhraseToPhraseList({
    @required String listId,
    @required Phrase phrase,
  }) {
    final req = AddPhraseToPhraseListRequest(listId: listId, phrase: phrase);
    return _userPersistence.addPhraseToPhraseList(req);
  }

  /// update phrase
  Future<User> updatePhrase({
    @required String listId,
    @required String phraseId,
    @required Phrase phrase,
  }) {
    final req =
        UpdatePhraseRequest(listId: listId, phraseId: phraseId, phrase: phrase);
    return _userPersistence.updatePhrase(req);
  }
}
