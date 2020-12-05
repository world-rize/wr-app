// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/billing_client_wrappers.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
import 'package:wr_app/util/sentry.dart';

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
    final user = Provider.of<UserNotifier>(context, listen: false).user;
    return FutureBuilder<List<Tuple4<ShopItem, bool, bool, bool>>>(
      future: _shopService.getShopItems().then((value) async {
        final l = <Tuple4<ShopItem, bool, bool, bool>>[];
        await Future.forEach(value, (element) async {
          final bs =
              await _shopService.purchasable(user: user, shopItem: element);
          l.add(Tuple4(element, bs.item1, bs.item2, bs.item3));
        });
        return l;
      }),
      builder: (_, snapshot) {
        if (snapshot.error != null) {
          sentryReportError(
              error: snapshot.error, stackTrace: StackTrace.current);
        }
        // ここをConnectionState.doneじゃないやつにすると期待通りにリロード画面が間に入る
        if (snapshot.data == null ||
            snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200],
              highlightColor: Colors.grey[400],
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
            ),
          );
        }

        return Column(
          children: snapshot.data
              .map(
                (t) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: ShopItemCard(
                    shopItem: t.item1,
                    onTap: () => showShopItemPurchaseConfirmDialog(
                        context: context, item: t.item1),
                    gettable: t.item2,
                    purchasable: t.item3,
                    alreadyPurchased: t.item4,
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
