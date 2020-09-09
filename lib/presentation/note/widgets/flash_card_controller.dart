// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

class FlashCardController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fn = Provider.of<FlashCardNotifier>(context);

    return ShadowedContainer(
      color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(8),
        key: GlobalKey(),
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GFIconButton(
                    icon: Icon(
                      Entypo.retweet,
                      color: fn.autoScroll ? Colors.black : Colors.grey,
                      size: GFSize.MEDIUM,
                    ),
                    color: Colors.transparent,
                    shape: GFIconButtonShape.circle,
                    onPressed: () async {
                      fn.toggleAutoScroll();
                    },
                  ),
                  RaisedButton(
                    onPressed: () async {
                      final fn = context.read<FlashCardNotifier>();
                      await fn.play();
                      print('tapped');
                      if (fn.autoScroll) {
                        await fn.nextPhrase();
                      }
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      final fn = context.read<FlashCardNotifier>();
                      await fn.play();
                      print('tapped');
                      if (fn.autoScroll) {
                        await fn.nextPhrase();
                      }
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
