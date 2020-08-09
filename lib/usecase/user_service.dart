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

    final req = CreateUserRequestDto(
      name: res.displayName,
      email: res.email,
      age: '0',
    );

    final _res = await _userPersistence.createUser(req);
    return _res.user;
  }

  /// sign up with email & password
  Future<User> signUpWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required String name,
      @required String age}) async {
    final req = CreateUserRequestDto(
      name: name,
      age: age,
      email: email,
    );

    await _authPersistence.signUpWithEmailAndPassword(email, password);
    final _res = await _userPersistence.createUser(req);
    return _res.user;
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await _authPersistence.signInWithEmailAndPassword(email, password);
    final _res = await _userPersistence.readUser(ReadUserRequestDto());
    return _res.user;
  }

  /// sign out
  Future<void> signOut() {
    return _authPersistence.signOut();
  }

  /// call test api
  Future<void> test() async {
    return _userPersistence.test(TestRequestDto());
  }

  /// ユーザーデータを習得します
  Future<User> getUser() async {
    final _res = await _userPersistence.readUser(ReadUserRequestDto());
    return _res.user;
  }

  /// フレーズをお気に入りに登録します
  Future<User> favorite({
    @required User user,
    @required String phraseId,
    @required bool value,
  }) async {
    final res = await _userPersistence.favoritePhrase(FavoritePhraseRequestDto(
        uid: user.uuid, phraseId: phraseId, value: value));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    user.favorites['default'].favoritePhraseIds[phraseId] =
        FavoritePhraseDigest(
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
    final res =
        await _userPersistence.updateUser(UpdateUserRequestDto(user: user));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    return user;
  }

  /// ポイントを習得します
  Future<User> getPoints({
    @required User user,
    @required int points,
  }) async {
    user.statistics.points += points;
    final res = await _userPersistence.getPoint(GetPointRequestDto(
      uid: user.uuid,
      points: points,
    ));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    return user;
  }

  Future<User> updateAge({@required User user, @required String age}) async {
    user.attributes.age = age;
    final res =
        await _userPersistence.updateUser(UpdateUserRequestDto(user: user));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    return user;
  }

  /// upgrade to Pro or downgrade
  Future<User> changePlan(
      {@required User user, @required Membership membership}) async {
    user.attributes.membership = membership;

    final res =
        await _userPersistence.updateUser(UpdateUserRequestDto(user: user));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    return user;
  }

  /// do test
  Future<User> doTest({@required User user}) async {
    user.statistics.testLimitCount--;
    final res = await _userPersistence.doTest(DoTestRequestDto(uid: user.uuid));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    return user;
  }

  /// update user
  Future<User> updateUser({@required User user}) async {
    final res =
        await _userPersistence.updateUser(UpdateUserRequestDto(user: user));

    if (!(res?.success ?? false)) {
      throw Exception('failed');
    }

    return user;
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

    await _authPersistence.updateEmail(newEmail);

    return user;
  }
}
