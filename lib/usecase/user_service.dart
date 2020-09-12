// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/util/logger.dart';

// TODO: Error handling
class UserService {
  const UserService({
    @required AuthRepository authPersistence,
    @required UserRepository userPersistence,
    @required ShopRepository shopPersistence,
  })  : _userPersistence = userPersistence,
        _authPersistence = authPersistence,
        _shopPersistence = shopPersistence;

  final AuthRepository _authPersistence;
  final UserRepository _userPersistence;
  final ShopRepository _shopPersistence;

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

    InAppLogger.debug('_userPersistence.signUpWithEmailAndPassword()');
    await _authPersistence.signUpWithEmailAndPassword(email, password);

    InAppLogger.debug('_userPersistence.createUser()');
    final user = await _userPersistence.createUser(req);

    InAppLogger.debug('_userPersistence.login()');
    await _userPersistence.login();

    return user;
  }

  /// sign up with Google
  Future<User> signUpWithGoogle(String name) async {
    InAppLogger.debug('_userPersistence.signInWithGoogleSignIn()');
    final fbUser = await _authPersistence.signInWithGoogleSignIn();

    InAppLogger.debug('_authPersistence.signUpWithGoogle()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');
    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);
    final req = CreateUserRequest(
      name: userName,
      email: fbUser.email,
      age: '0',
    );

    InAppLogger.debug('_userPersistence.createUser()');
    final user = _userPersistence.createUser(req);

    InAppLogger.debug('_userPersistence.login()');
    await _userPersistence.login();

    return user;
  }

  /// sign up with SIWA
  Future<User> signUpWithApple(String name) async {
    final fbUser = await _authPersistence.signInWithSignInWithApple();

    InAppLogger.debug('_authPersistence.signUpWithApple()');
    InAppLogger.debug('displayName: ${fbUser.displayName}');
    InAppLogger.debug('email: ${fbUser.email}');

    final userName = name ?? fbUser.displayName ?? '';
    assert(userName.isNotEmpty);
    final req = CreateUserRequest(
      name: name,
      email: fbUser.email ?? '',
      age: '0',
    );

    InAppLogger.debug('_userPersistence.createUser()');
    final user = await _userPersistence.createUser(req);

    InAppLogger.debug('_userPersistence.login()');
    await _userPersistence.login();

    return user;
  }

  /// sign in with email & password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    InAppLogger.debug('_userPersistence.signInWithEmailAndPassword()');
    await _authPersistence.signInWithEmailAndPassword(email, password);

    InAppLogger.debug('_userPersistence.readUser()');
    final user = await _userPersistence.readUser();

    InAppLogger.debug('_userPersistence.login()');
    await _userPersistence.login();

    return user;
  }

  /// sign in with google
  Future<User> signInWithGoogle() async {
    InAppLogger.debug('_authPersistence.signInWithGoogleSignIn()');
    await _authPersistence.signInWithGoogleSignIn();

    InAppLogger.debug('_userPersistence.readUser()');
    final user = await _userPersistence.readUser();

    InAppLogger.debug('_userPersistence.login()');
    await _userPersistence.login();

    return user;
  }

  /// sign in with apple
  Future<User> signInWithApple() async {
    InAppLogger.debug('_authPersistence.signInWithSignInWithApple()');
    await _authPersistence.signInWithSignInWithApple();

    InAppLogger.debug('_userPersistence.readUser()');
    final user = await _userPersistence.readUser();

    InAppLogger.debug('_userPersistence.login()');
    await _userPersistence.login();

    return user;
  }

  /// sign out
  Future<void> signOut() {
    return _authPersistence.signOut();
  }

  /// login
  Future<void> login() {
    return _userPersistence.login();
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

  /// search user from User ID
  /// TODO: implement API
  Future<User> searchUserFromUserId({@required String userId}) {
    final req = FindUserByUserIdRequest(userId: userId);
    return _userPersistence.findUserByUserId(req);
  }

  /// check test streaks
  Future<bool> checkTestStreaks() {
    final req = CheckTestStreaksRequest();
    return _userPersistence.checkTestStreaks(req);
  }

  Future<List<GiftItem>> getShopItems() {
    return _shopPersistence.shopItems();
  }

  Future<User> purchaseItem({
    @required User user,
    @required String itemId,
  }) async {
    final item = (await _shopPersistence.shopItems())
        .firstWhere((item) => item.id == itemId);
    if (item == null) {
      return user;
    }
    user.items.putIfAbsent(item.id, () => 0);
    user.items[item.id] += 1;
    user.statistics.points -= item.price;

    return user;
//    final req = PurchaseItemRequest(itemId: itemId);
//    return _userPersistence.purchaseItem(req);
  }

  Future<bool> isAlreadySignedIn() {
    return _authPersistence.isAlreadySignedIn();
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _authPersistence.sendPasswordResetEmail(email);
  }
}
