// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/model/shop_item_id.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';

class ShopPageNotifier with ChangeNotifier {
  final ShopService _shopService;
  final UserService _userService;

  /// singleton
  static ShopPageNotifier _cache;

  bool isLoading = false;
  List<ShopItem> items = [];

  ShopPageNotifier._internal({
    @required UserService userService,
    @required ShopService shopService,
  })  : _userService = userService,
        _shopService = shopService;

  factory ShopPageNotifier({
    @required UserService userService,
    @required ShopService shopService,
  }) {
    return _cache ??= ShopPageNotifier._internal(
        userService: userService, shopService: shopService);
  }

  Future<List<ShopItem>> getShopItems() {
    return _shopService.getShopItems();
  }

  Future useItem(BuildContext context, ShopItemId id) async {
    final uuid = FirebaseAuth.instance.currentUser.uid;
    // 購入した瞬間使用
    // TODO: アクセント追加処理, ノート追加処理
    print(id);
    switch (id) {
      case ShopItemId.iTunes:
        await _shopService.sendITunesRequest(uid: uuid);
        await showGiftItemDescriptionDialog(
            context: context, description: I.of(context).shopPageSuccess);
        break;
      case ShopItemId.amazon:
        await _shopService.sendITunesRequest(uid: uuid);
        await showGiftItemDescriptionDialog(
            context: context, description: I.of(context).shopPageSuccess);
        break;
      default:
        break;
    }
  }

  /// アイテムの説明テキスト
  Future showGiftItemDescriptionDialog({
    @required BuildContext context,
    @required String description,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(description),
        actions: [
          FlatButton(
            child: Text(I.of(context).ok),
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future showPurchaseConfirmDialog(BuildContext context, ShopItem item) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(I.of(context).shopPagePurchase),
        content:
            Text(I.of(context).shopPageConfirmDialog(item.title, item.price)),
        actions: [
          FlatButton(
            child: Text(I.of(context).cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(I.of(context).ok),
            onPressed: () async {
              Navigator.pop(context);
              try {
                isLoading = true;
                notifyListeners();
                final uuid = FirebaseAuth.instance.currentUser.uid;
                final user = await _userService.readUser(uuid: uuid);
                final updatedUser = await _shopService.purchaseItem(
                    user: user, itemId: item.id);
                await useItem(context, ShopItemIdEx.fromString(item.id));
                await _userService.updateUser(user: updatedUser);
              } on Exception catch (e) {
                InAppLogger.error(e);
              } finally {
                isLoading = false;
                notifyListeners();
              }
            },
          )
        ],
      ),
    );
  }

  /// fetch shop items
  Future fetchShopItems() async {
    if (items.isNotEmpty) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners();
      items = await _shopService.getShopItems();
      notifyListeners();
    } on Exception catch (e) {
      InAppLogger.error(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// purchase item
  Future<void> purchaseItem({
    @required String itemId,
  }) async {
    final uuid = FirebaseAuth.instance.currentUser.uid;
    final user = await _userService.readUser(uuid: uuid);
    final updatedUser =
        await _shopService.purchaseItem(user: user, itemId: itemId);
    await _userService.updateUser(user: updatedUser);
    notifyListeners();
  }
}
