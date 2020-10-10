// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/gift_item_id.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/widgets/gift_item_card.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/util/logger.dart';

/// ポイント交換
class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _ShopPageNotifier(
        shopService: GetIt.I<ShopService>(),
        userService: GetIt.I<UserService>(),
      ),
      child: _ShopPage(),
    );
  }
}

class _ShopPageNotifier extends ChangeNotifier {
  _ShopPageNotifier({
    @required ShopService shopService,
    @required UserService userService,
  })  : _shopService = shopService,
        _userService = userService,
        _items = shopService.getShopItems(),
        _user = userService.readUser();

  final ShopService _shopService;
  final UserService _userService;
  Future<User> _user;
  Future<List<GiftItem>> get items => _items;
  Future<List<GiftItem>> _items;

  /// purchase item
  Future<void> purchaseItem({@required GiftItemId itemId}) async {
    print('waiting purchase item');
    _user = _shopService.purchaseItem(user: await _user, itemId: itemId.key);
    print('done purchase item');
  }

  Future sendAmazonGiftRequest({@required String uid}) {
    return _shopService.sendAmazonGiftRequest(uid: uid);
  }

  Future sendITunesRequest({@required String uid}) {
    return _shopService.sendITunesRequest(uid: uid);
  }
}

class _ShopPage extends StatelessWidget {
  /// 購入確認ダイアログをだす
  Future _showPurchaseConfirmDialog(BuildContext context, GiftItem item) {
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
                final sn = context.read<_ShopPageNotifier>();
                await sn.purchaseItem(itemId: GiftItemIdEx.fromString(item.id));
                await _useItem(context, GiftItemIdEx.fromString(item.id));
              } on Exception catch (e) {
                InAppLogger.error(e);
              }
            },
          )
        ],
      ),
    );
  }

  Future _useItem(BuildContext context, GiftItemId id) async {
    final un = context.read<UserNotifier>();
    final sn = context.read<_ShopPageNotifier>();
    // 購入した瞬間使用
    // TODO: アクセント追加処理, ノート追加処理
    print(id);
    switch (id) {
      case GiftItemId.iTunes:
        await sn.sendITunesRequest(uid: un.user.uuid);
        await _showGiftItemDescriptionDialog(
            context, I.of(context).shopPageSuccess);
        break;
      case GiftItemId.amazon:
        await sn.sendITunesRequest(uid: un.user.uuid);
        await _showGiftItemDescriptionDialog(
            context, I.of(context).shopPageSuccess);
        break;
      default:
        break;
    }
  }

  /// アイテムの説明テキスト
  Future _showGiftItemDescriptionDialog(
    BuildContext context,
    String description,
  ) {
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

  @override
  Widget build(BuildContext context) {
    final h = Theme.of(context).primaryTextTheme.headline3;
    final b = Theme.of(context).primaryTextTheme.bodyText1;
    final userNotifier = Provider.of<UserNotifier>(context);
    final spn = Provider.of<_ShopPageNotifier>(context);
    final points = userNotifier.user.statistics.points;

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).myPageShopButton),
      ),
      body: FutureBuilder(
        future: spn.items,
        builder:
            (BuildContext context, AsyncSnapshot<List<GiftItem>> snapshot) {
          if (snapshot.hasError) {
            InAppLogger.error(snapshot.error);
          }
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    I.of(context).havingCoin,
                    style: h,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    I.of(context).points(points),
                    style: b,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '交換できるもの',
                    style: h,
                  ),
                ),
                Column(
                  children: snapshot.data
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: GiftItemCard(
                            giftItem: item,
                            onTap: () {
                              _showPurchaseConfirmDialog(context, item);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
