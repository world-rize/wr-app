// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/domain/user/membership.dart';
import 'package:wr_app/domain/user/user.dart';
import 'package:wr_app/domain/user/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';

class UserService {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  const UserService({
    @required AuthRepository authRepository,
    @required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository;

  /// sign up with Google
  Future<User> signUpWithGoogle() async {
    await _authRepository.signInWithGoogleSignIn();
    final _res = await _userRepository.createUser(CreateUserRequestDto());
    return _res.user;
  }

  /// sign up with email & password
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    await _authRepository.signUpWithEmailAndPassword(email, password);
    final _res = await _userRepository.createUser(CreateUserRequestDto());
    return _res.user;
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await _authRepository.signInWithEmailAndPassword(email, password);
    final _res = await _userRepository.readUser(ReadUserRequestDto());
    return _res.user;
  }

  /// sign out
  Future<void> signOut() {
    return _authRepository.signOut();
  }

  /// call test api
  Future<void> test() async {
    return _userRepository.test(TestRequestDto());
  }

  /// ユーザーデータを習得します
  Future<User> getUser() async {
    final _res = await _userRepository.readUser(ReadUserRequestDto());
    return _res.user;
  }

  /// フレーズをお気に入りに登録します
  Future<void> favorite({
    @required User user,
    @required String phraseId,
    @required bool value,
  }) {
    // TODO: auth check
    return _userRepository.favoritePhrase(FavoritePhraseRequestDto(
        uid: user.uuid, phraseId: phraseId, value: value));
  }

  /// 受講可能回数をリセット
  Future<void> resetTestCount() {
    // TODO: implement
    throw UnimplementedError();
  }

  /// ポイントを習得します
  Future<void> getPoints({
    @required User user,
    @required int point,
  }) {
    return _userRepository.getPoint(GetPointRequestDto(
      uid: user.uuid,
      point: point,
    ));
  }

  /// upgrade to Pro or downgrade
  Future<void> changePlan(Membership membership) {
    // TODO: implement
  }

  /// do test
  Future<void> doTest({@required User user}) {
    return _userRepository
        .doTest(DoTestRequestDto(uid: user.uuid, sectionId: ''));
  }
}
