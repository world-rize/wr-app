// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/infrastructure/shop/shop_repository.dart';
import 'package:wr_app/presentation/mypage/notifier/shop_page_notifier.dart';
import 'package:wr_app/presentation/mypage/widgets/gift_item_card.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/usecase/user_service.dart';

/// ポイント交換
class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shopService = ShopService(
        shopRepository: ShopRepository(store: GetIt.I<FirebaseFirestore>()));

    return ChangeNotifierProvider(
      create: (_) => ShopPageNotifier(
          userService: GetIt.I<UserService>(), shopService: shopService),
      child: _ShopIndexPage(),
    );
  }
}

class _ShopIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ShopPageNotifier>();

    final h = Theme.of(context).primaryTextTheme.headline3;
    final b = Theme.of(context).primaryTextTheme.bodyText1;
    final userNotifier = Provider.of<UserNotifier>(context);
    final points = userNotifier.user.statistics.points;

    state.fetchShopItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).myPageShopButton),
      ),
      body: LoadingView(
        loading: state.isLoading,
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
                children: state.items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: GiftItemCard(
                          giftItem: item,
                          onTap: () {
                            state.purchaseItem(itemId: item.id);
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
