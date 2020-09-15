// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/model/membership.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';

// TODO: Error handling
class UserService {
  const UserService({
    @required UserRepository userPersistence,
    @required ShopRepository shopPersistence,
  })  : _userPersistence = userPersistence,
        _shopPersistence = shopPersistence;

  final UserRepository _userPersistence;
  final ShopRepository _shopPersistence;

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

  /// ショップのアイテムを取得
  // TODO: shopServiceを作成
  Future<List<GiftItem>> getShopItems() {
    return _shopPersistence.shopItems();
  }

  /// アイテムを購入
  // TODO: shopServiceを作成
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

  /// 友達紹介をする
  Future<void> introduceFriend({@required String introduceeUserId}) {
    final req = IntroduceFriendRequest(introduceeUserId: introduceeUserId);
    return _userPersistence.introduceFriend(req);
  }
}
