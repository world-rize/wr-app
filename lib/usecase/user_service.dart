// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';

// TODO(someone): Error handling
// update api returns updated object
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
    return _userPersistence.createUser(req);
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await _authPersistence.signInWithEmailAndPassword(email, password);
    return _userPersistence.readUser();
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
  Future<User> getUser() async {
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
    await _userPersistence.favoritePhrase(req);

    user.favorites[listId].favoritePhraseIds[phraseId] = FavoritePhraseDigest(
      id: phraseId,
      createdAt: DateTime.now(),
    );
    return user;
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
    user.statistics.points += points;
    final req = GetPointRequest(
      points: points,
    );
    final res = await _userPersistence.getPoint(req);
    return user;
  }

  Future<User> updateAge({@required User user, @required String age}) async {
    user.attributes.age = age;

    return _userPersistence.updateUser(user);
  }

  /// upgrade to Pro or downgrade
  Future<User> changePlan({
    @required User user,
    @required Membership membership,
  }) async {
    user.attributes.membership = membership;
    return _userPersistence.updateUser(user);
  }

  /// do test
  Future<void> doTest({
    @required User user,
    @required String sectionId,
  }) async {
    user.statistics.testLimitCount--;
    return _userPersistence.doTest(DoTestRequest(sectionId: sectionId));
  }

  /// update user
  Future<User> updateUser({@required User user}) async {
    return _userPersistence.updateUser(user);
  }

  /// update password
  Future<void> updatePassword(
      {@required String currentPassword, @required String newPassword}) {
    return _authPersistence.updatePassword(currentPassword, newPassword);
  }

  /// update email
  Future<User> updateEmail(
      {@required User user, @required String newEmail}) async {
    user.attributes.email = newEmail;
    await _userPersistence.updateUser(user);
    await _authPersistence.updateEmail(newEmail);

    return user;
  }
}
