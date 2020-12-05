// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';
import 'package:wr_app/domain/shop/model/receipt.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/model/shop_item_id.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/widgets/shop_item_card.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/logger.dart';

///
/// 1. ShopItemCard: onTap
/// 2. 購入しますか？ yes/no
/// 3. 説明ダイアログ ok
class ShopPageNotifier with ChangeNotifier {
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

  final ShopService _shopService;
  final UserService _userService;

  /// singleton
  static ShopPageNotifier _cache;

  bool isLoading = false;

  // 1. ShopItemCard: onTap
  // TODO: 非同期なWidgetはどこにおくべき?
  Widget shopItemCards(BuildContext context) {
    return FutureBuilder<List<ShopItem>>(
      future: _shopService.getShopItems(),
      builder: (_, ss) {
        if (ss.hasError) {
          return Text('Error');
        }
        if (!ss.hasData) {
          return CircularProgressIndicator();
        }

        return Column(
          children: ss.data
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: ShopItemCard(
                    shopItem: item,
                    onTap: () => showShopItemPurchaseConfirmDialog(
                        context: context, item: item),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  // 2. 購入しますか？ yes/no
  Future showShopItemPurchaseConfirmDialog({
    @required BuildContext context,
    @required ShopItem item,
  }) {
    final dialog = AlertDialog(
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
            await _purchaseShopItem(context: context, item: item);
            Navigator.pop(context);
            await showShopItemDescriptionDialog(context: context, item: item);
          },
        )
      ],
    );

    return showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }

  // 3. 説明ダイアログ ok
  Future showShopItemDescriptionDialog({
    @required BuildContext context,
    @required ShopItem item,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(item.description),
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

  Future _useItem(BuildContext context, ShopItem item) async {
    final uid = fa.FirebaseAuth.instance.currentUser.uid;
    final itemId = ShopItemIdEx.fromString(item.id);

    // 購入した瞬間使用
    // TODO: アクセント追加処理, ノート追加処理
    switch (itemId) {
      case ShopItemId.iTunes:
        await _shopService.sendITunesRequest(uid: uid);
        await showShopItemDescriptionDialog(context: context, item: item);
        break;
      case ShopItemId.amazon:
        await _shopService.sendITunesRequest(uid: uid);
        await showShopItemDescriptionDialog(context: context, item: item);
        break;
      default:
        break;
    }
  }

  Future _purchaseShopItem({
    @required BuildContext context,
    @required ShopItem item,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final user = await _userService.fetchUser(uid: _userService.getUid());
      final updatedUser =
          await _shopService.purchaseItem(user: user, itemId: item.id);
      await _useItem(context, item);
      await _userService.updateUser(user: updatedUser);
      // TODO: globalなstoreみたいな使い方をしていてあんまり良くない。storeを作ろう
      UserNotifier(userService: GetIt.I<UserService>()).user = updatedUser;
    } on Exception catch (e) {
      InAppLogger.error(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// レシートとitemの性質からUserがそのitemを買うことができるかを調べる
  /// return (itemを何個もかえるか, ポイントが足りているか, すでに買ったことがあるか)
  Future<Tuple3<bool, bool, bool>> purchasable({
    @required User user,
    @required ShopItem shopItem,
  }) {
    return _shopService.purchasable(user: user, shopItem: shopItem);
  }
}
