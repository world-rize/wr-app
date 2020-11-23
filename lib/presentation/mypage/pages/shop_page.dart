// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/infrastructure/shop/shop_repository.dart';
import 'package:wr_app/presentation/mypage/notifier/shop_page_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/extensions.dart';

/// ショップページ
///
/// アクセントの購入やノート枠の追加などのアイテムが買える
class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shopService = ShopService(
        shopRepository: ShopRepository(store: GetIt.I<FirebaseFirestore>()));
    final cn = ShopPageNotifier(
      userService: GetIt.I<UserService>(),
      shopService: shopService,
    );

    return ChangeNotifierProvider.value(
      value: cn,
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
    final points = userNotifier.user.points;

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
              Text(
                I.of(context).havingCoin,
                style: h,
              ).padding(),
              Text(
                I.of(context).points(points),
                style: b,
              ).padding(),
              Text(
                '交換できるもの',
                style: h,
              ).padding(),
              state.shopItemCards(context),
            ],
          ),
        ),
      ),
    );
  }
}
