// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/gift_item_id.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/presentation/mypage/widgets/gift_item_card.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';
import 'package:wr_app/presentation/shop_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
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
        title: const Text('購入'),
        content: Text('${item.title} を ${item.price} コインで購入しますか？'),
        actions: [
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('Ok'),
            onPressed: () async {
              print('before pop');
              Navigator.pop(context);
              print('after pop');
              try {
                print('befeore set state');
                setState(() {
                  _isLoading = true;
                });
                print('after set state');
                final sn = context.read<ShopNotifier>();
                print('before purchas imt');
                await sn.purchaseItem(itemId: GiftItemIdEx.fromString(item.id));
                print('before use item');
                await _useItem(GiftItemIdEx.fromString(item.id));
                print('after use item');
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
        await _showGiftItemDescriptionDialog(
            '交換が確定されました。2週間以内に登録されているメールアドレスにギフトコードを送信します');
        break;
      case GiftItemId.amazon:
        await sn.sendITunesRequest(uid: un.user.uuid);
        await _showGiftItemDescriptionDialog(
            '交換が確定されました。2週間以内に登録されているメールアドレスにギフトコードを送信します');
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
            child: const Text('Ok'),
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
    final userNotifier = Provider.of<UserNotifier>(context);
    final points = userNotifier.user.statistics.points;
    if (_items.isEmpty) {
      _getShopItems();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ショップ'),
      ),
      body: LoadingView(
        loading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('保有しているコイン'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$points'),
                    const Text('WR coins'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('交換できるもの'),
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
