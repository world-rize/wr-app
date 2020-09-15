// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/presentation/mypage/notifier/shop_notifier.dart';
import 'package:wr_app/presentation/mypage/widgets/gift_item_card.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';
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

  void _showPurchaseConfirmDialog(GiftItem item) {
    showDialog(
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
              Navigator.pop(context);
              try {
                setState(() {
                  _isLoading = true;
                });
                final sn = context.read<ShopNotifier>();
                await sn.purchaseItem(itemId: item.id);
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
                            _showPurchaseConfirmDialog(item);
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
