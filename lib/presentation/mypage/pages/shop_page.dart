// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/gift_item_id.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/widgets/gift_item_card.dart';
import 'package:wr_app/presentation/shop_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/util/logger.dart';

/// ポイント交換
class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _isLoading;
  List<GiftItem> _items = [];

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  Future _getShopItems() async {
    final shopNotifier = Provider.of<ShopNotifier>(context, listen: false);

    try {
      setState(() {
        _isLoading = true;
      });
      final items = await shopNotifier.getShopItems();
      setState(() {
        _items = items;
      });
    } on Exception catch (e) {
      InAppLogger.error(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 購入確認ダイアログをだす
  Future _showPurchaseConfirmDialog(GiftItem item) {
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
                setState(() {
                  _isLoading = true;
                });
                final sn = context.read<ShopNotifier>();
                await sn.purchaseItem(itemId: GiftItemIdEx.fromString(item.id));
                final un = context.read<UserNotifier>();
                await un.callGetPoint(points: -item.price);
                await _useItem(GiftItemIdEx.fromString(item.id));
              } on Exception catch (e) {
                InAppLogger.error(e);
              } finally {
                setState(() {
                  _isLoading = false;
                });
              }
            },
          )
        ],
      ),
    );
  }

  Future _useItem(GiftItemId id) async {
    final un = context.read<UserNotifier>();
    final sn = context.read<ShopNotifier>();
    // 購入した瞬間使用
    // TODO: アクセント追加処理, ノート追加処理
    print(id);
    switch (id) {
      case GiftItemId.iTunes:
        await sn.sendITunesRequest(uid: un.user.uuid);
        await _showGiftItemDescriptionDialog(I.of(context).shopPageSuccess);
        break;
      case GiftItemId.amazon:
        await sn.sendITunesRequest(uid: un.user.uuid);
        await _showGiftItemDescriptionDialog(I.of(context).shopPageSuccess);
        break;
      default:
        break;
    }
  }

  /// アイテムの説明テキスト
  Future _showGiftItemDescriptionDialog(String description) {
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

  /// アイテムの購入 & 使用
  Future _purchase(GiftItem item) async {
    await _showPurchaseConfirmDialog(item);
  }

  @override
  Widget build(BuildContext context) {
    final h = Theme.of(context).primaryTextTheme.headline3;
    final b = Theme.of(context).primaryTextTheme.bodyText1;
    final userNotifier = Provider.of<UserNotifier>(context);
    final points = userNotifier.user.statistics.points;
    if (_items.isEmpty) {
      _getShopItems();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).myPageShopButton),
      ),
      body: LoadingView(
        loading: _isLoading,
        child: SingleChildScrollView(
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
                children: _items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: GiftItemCard(
                          giftItem: item,
                          onTap: () {
                            _purchase(item);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
